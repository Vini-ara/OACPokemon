# /bin/bash

for file in `ls ./*.bmp`
do 
  ./bmp_to_data "${file}"
done
