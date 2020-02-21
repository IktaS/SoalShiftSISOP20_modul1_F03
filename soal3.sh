#!/bin/bash


kenloc=kenangan
duploc=duplicate


[ ! -d "$kenloc" ] && mkdir -p "$kenloc"
[ ! -d "$duploc" ] && mkdir -p "$duploc"
echo "" >> location.log

for (( i = 1; i < 29; i++ )); do
  name=pdkt_kusuma_$i
  wget -O $name "https://loremflickr.com/320/240/cat" -o temp.log
  loc=`grep "Location: " temp.log | cut -d "/" -f4 | cut -d " " -f1`
  lastkennum=`ls $kenloc/ | grep -c "kenangan_"`
  lastdupnum=`ls $duploc/ | grep -c "duplicate_"`
  cat temp.log >> wget.log
  rm temp.log
  if [[ $(grep -c $loc location.log) > 0 ]]; then
    num=`expr $lastdupnum + 1`
    name2=duplicate_$num
    mv $name $name2
    mv $name2 $duploc/
  else
    num=`expr $lastkennum + 1`
    name2=kenangan_$num
    mv $name $name2
    mv $name2 $kenloc/
    echo $loc >> location.log
  fi
done
mv wget.log wget.log.bak
mv location.log location.log.bak
