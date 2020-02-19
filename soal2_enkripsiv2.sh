#!/bin/bash

set1=`echo {a..z} {a..z} | tr -d " "`;
set2=`echo {A..Z} {A..Z} | tr -d " "`;
tempstring=$(echo $1 | cut -d "." -f 1 | tr ${set1:0:26}${set2:0:26} ${set1:`date +%H`:26}${set2:`date +%H`:26})
mv $1 $tempstring.txt
