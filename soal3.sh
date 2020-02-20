#!/bin/bash

location=~/SisOp/Praktikum1

#location=~/SoalShiftSISOP20_modul1_F03/kenangan
#location=~/SoalShiftSISOP20_modul1_F03/kenangan
lastnum=`ls | grep -c "kenangan_"`
addnum=`expr $lastnum + 1`
mkdir $location/kenangan_$addnum
mkdir $location/duplicate_$addnum
echo "" > location.log


for (( i = 1; i < 29; i++ )); do
  wget "https://loremflickr.com/320/240/cat" -o wget.log
  loc=`grep "Location: " wget.log | cut -d "/" -f4 | cut -d " " -f1`
  name=pdkt_kusuma_$i
  mv cat $name
  if [[ $(grep -c $loc location.log) > 0 ]]; then
    mv $name $location/duplicate_$addnum
  else
    mv $name $location/kenangan_$addnum
    echo $loc >> location.log
  fi
done
rm location.log
