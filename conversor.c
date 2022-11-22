#include <stdio.h>

typedef unsigned char byte;
typedef unsigned short int16;
typedef unsigned int int32;

typedef struct typeBMPHEADER {
  int16 type;
  int32 size;
  int32 reserved;
  int32 offset;
} BMPHEADER;

typedef struct typeBMPV5DIBHEADER {
  int32 dibSize;
  int32 width;
  int32 height;
} BMPV5HEADER;

typedef struct typeBMPDIBHEADER {
  int32 dibSize;
  int16 width;
  int16 height;
} BMPDIBHEADER;

void readBmpHeader(BMPHEADER *header, FILE *image) {
  fseek(image, 0, SEEK_SET);
  fread(&(*header).type, 2, 1, image);
  printf("%X\n", (*header).type);

  fseek(image, 0x2, SEEK_SET);
  fread(&(*header).size, 4, 1, image);
  printf("%d\n", (*header).size);

  fseek(image, 0x6, SEEK_SET);
  fread(&(*header).reserved, 4, 1, image);

  fseek(image, 0xA, SEEK_SET);
  fread(&(*header).offset, 4, 1, image);
  printf("%d\n", (*header).offset);
}

void getBMPDimensions(int32 *width, int32 *height, FILE *image) {
  int32 dibSize;
  fseek(image, 0x0E, SEEK_SET);
  fread(&dibSize, 4, 1, image);

  if (dibSize == 12 || dibSize == 64 || dibSize == 16) {
    fseek(image, 0x12, SEEK_SET);
    fread(width, 2, 1, image);
    fseek(image, 0x14, SEEK_SET);
    fread(height, 2, 1, image);
  }

  if (dibSize == 124 || dibSize == 40) {
    fseek(image, 0x12, SEEK_SET);
    fread(width, 4, 1, image);
    fseek(image, 0x16, SEEK_SET);
    fread(height, 4, 1, image);
  }
}

void readBmpImage(FILE* image, int32 height, int32 width, byte pixelGrid[height][width][3]) {
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

int main() {
  FILE *image = fopen("test.bmp", "rb");
  FILE *output = fopen("out", "w");

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
  }

  return 0;
}
