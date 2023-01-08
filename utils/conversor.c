#include <stdio.h>
#include <stdlib.h>

typedef unsigned char byte;
typedef unsigned short int16;
typedef unsigned int int32;

typedef struct typeBMPHEADER {
  int16 type;
  int32 size;
  int32 reserved;
  int32 offset;
} BMPHEADER;

void readBmpHeader(BMPHEADER *header, FILE *image) {
  fseek(image, 0, SEEK_SET);
  fread(&(*header).type, 2, 1, image);

  fseek(image, 0x2, SEEK_SET);
  fread(&(*header).size, 4, 1, image);

  fseek(image, 0x6, SEEK_SET);
  fread(&(*header).reserved, 4, 1, image);

  fseek(image, 0xA, SEEK_SET);
  fread(&(*header).offset, 4, 1, image);
}

void getBMPDimensions(int32 *width, int32 *height, FILE *image) {
  int32 dibSize;
  fseek(image, 0x0E, SEEK_SET);
  fread(&dibSize, 4, 1, image);

  if (dibSize == 12) {
    fseek(image, 0x12, SEEK_SET);
    fread(width, 2, 1, image);
    fseek(image, 0x14, SEEK_SET);
    fread(height, 2, 1, image);
  } else {
    fseek(image, 0x12, SEEK_SET);
    fread(width, 4, 1, image);
    fseek(image, 0x16, SEEK_SET);
    fread(height, 4, 1, image);
  }
}

void readBmpImage(FILE *image, int32 height, int32 width,
                  byte pixelGrid[height][width][3]) {
  int padding = width % 4;

  for (int i = height - 1; i >= 0; i--) {
    for (int j = 0; j < width; j++) {
      pixelGrid[i][j][0] = getc(image);
      pixelGrid[i][j][1] = getc(image);
      pixelGrid[i][j][2] = getc(image);
    }
    for (int p = 0; p < padding; p++)
      getc(image);
  }
}

int main(int argc, char **argv) {
  if (argc != 2) {
    printf("You should pass the bmp file name\n");
    exit(1);
  }

  char name[30];
  sprintf(name, "%s.bmp", argv[1]);

  FILE *image = fopen(name, "rb");
  FILE *output = fopen("matrix.s", "w");

  if(image == NULL) {
    printf("Erro ao abrir o arquivo de entrada\n");
    exit(1);
  }

  if(output == NULL) {
    printf("Erro ao criar o arquivo de saida\n");
    exit(1);
  }

  BMPHEADER header;

  int32 height, width;

  readBmpHeader(&header, image);

  getBMPDimensions(&width, &height, image);

  byte pixelGrid[height][width][3];

  fseek(image, header.offset, SEEK_SET);

  readBmpImage(image, height, width, pixelGrid);

  fprintf(output, ".data\nMATRIX: .word ");

  for (int i = 0; i < height; i++) {
    for (int j = 0; j < width; j++) {
      int32 pixel = 0;
      pixel = ((int32)pixelGrid[i][j][2] << 16) +
              ((int32)pixelGrid[i][j][1] << 8) + (int32)pixelGrid[i][j][0];
      fprintf(output, "0x%08X, ", pixel);
    }
    fprintf(output, "\n              ");
  }

  fclose(image);
  fclose(output);

  printf("image size: %d X %d\n", width, height);

  return 0;
}
