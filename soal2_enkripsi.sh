#!/bin/bash

namestring=""
function csr_cipher() {
  tempstring=`echo $1 | cut -d "." -f1`
  addnumber=`date +%H`
  for (( i=0; i<${#tempstring}; i++ )); do
    charascval=`echo "${tempstring:$i:1}"`
    charascval=`printf "%d" "'$charascval"`
    charascval=`expr $charascval + $addnumber`
    if [[ $charascval > 122 || $charascval > 90 ]]; then
      if [[ $charascval < 65 || $charascval < 97 ]]; then
        charascval=`expr $charascval - 26`
      fi
    fi
    charascval=`echo "obase=8;$charascval"|bc`
    namestring=$namestring`echo -e "\\0$charascval"`
  done
}
csr_cipher $1
mv $1 $namestring.txt
