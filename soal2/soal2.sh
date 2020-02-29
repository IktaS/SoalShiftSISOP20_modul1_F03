#!/bin/bash

#cat /dev/urandom | tr -cd 'a-zA-Z0-9' | fold -w 1 | head -n 1 > $1.txt

function lowerrand(){
  cat /dev/urandom | tr -cd 'a-z' | fold -w 1 | head -n 1
}

function upperrand(){
  cat /dev/urandom | tr -cd 'A-Z' | fold -w 1 | head -n 1
}

function digitrand(){
  cat /dev/urandom | tr -cd '0-9' | fold -w 1 | head -n 1
}

function randstring(){
  for (( i = 0; i < $1; i++ )); do
    rand=`expr $i % 3`
    case $rand in
      [0])
        tempstring=$tempstring`lowerrand`
        ;;
      [1])
        tempstring=$tempstring`upperrand`
        ;;
      [2])
        tempstring=$tempstring`digitrand`
        ;;
    esac
  done
  echo $tempstring;
}

if [[ $1 =~ [0-9] ]]; then
  echo bad argument;
else
  echo `randstring 28 | fold -w1 | shuf | tr -d '\n'` > $1.txt;
fi
