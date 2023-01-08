from PIL import Image;
import os;

path = input()

img = Image.open(path)
img.convert('RGB')
pixel_values = list(img.getdata())
string = ''
file = open('mapa.txt','w')
i = 1
for pixel in pixel_values:
    red = pixel[0]
    green = pixel[1]
    blue = pixel[2]
    valor = red+green+blue
    string += str(valor)
    
    string += ','

    if(i%80 == 0):
        string+= '\n'
    i+=1

file.write(string)
file.close()