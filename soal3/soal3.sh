#!/bin/bash

#3.a
if [[ `ls | grep -c "pdkt_kusuma_"` == 0 ]]; then
  lastnum=0
else
  lastnum=$(ls | grep "pdkt_kusuma_" | cut -d "_" -f3 | sort -n | tail -1)
fi
for (( i = 1; i < 29; i++ )); do
  num=`expr $i + $lastnum`
  wget -O pdkt_kusuma_$num -a wget.log "https://loremflickr.com/320/240/cat"
done
