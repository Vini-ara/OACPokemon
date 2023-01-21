# /bin/bash

for file in `ls ./*.bmp`
do 
  ./converter "${file}"
done
