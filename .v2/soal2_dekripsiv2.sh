#!/bin/bash

set1=`echo {z..a} {z..a} | tr -d " "`;
set2=`echo {Z..A} {Z..A} | tr -d " "`;
tempstring=$(echo $1 | cut -d "." -f 1 | tr ${set1:0:26}${set2:0:26} ${set1:$2:26}${set2:$2:26})
mv $1 $tempstring.txt
