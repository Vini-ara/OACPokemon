# /bin/bash

for file in `ls *.bmp`
do 
  ./bmp_to_data "${file}"
done

for file in `ls ./*.bmp`
do 
  ./bmp_to_data "${file}"
done

rm -rf *.bin *.mif
rm -rf *U*
rm -rf *V*
