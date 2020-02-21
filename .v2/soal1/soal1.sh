#!/bin/bash

#3.a
lowestreg=$(awk -F'\t' '
{
    i++;
    if(i!=1){
      sum[$13] += $21;
    }
}END{
  curmin=999999.00;
  for(it in sum){
    if( sum[it] < curmin ){
      curmin = sum[it];
      min = it;
    }
  }
  print min;
}
' Sample-Superstore.tsv)
#3.b
twolowstate=$(awk -v lowestreg="$lowestreg" -F'\t' '{
  i++;
  if(i!=1){
    if($13 == lowestreg){
      sum[$11] += $21;
    }
  }
}END{
  firststate="";
  secondstate="";
  first = 999999999;
  sec = 999999999;
  for(it in sum){
    if(sum[it] < first){
      second = first;
      first = sum[it];
      secondstate = firststate;
      firststate = it
    }else if(sum[it] < second && sum[it] != first){
      second = sum[it];
      secondstate = it;
    }
  }
  if(second == 999999999){
    printf "%s\n",firststate;
  }else{
    printf "%s\n",firststate;
    printf "%s\n",secondstate;
  }
}' Sample-Superstore.tsv)
echo $twolowstate

arrstate=($twolowstate)

awk -v state1="${arrstate[0]}" -v state2="${arrstate[1]}" -F'\t' '{
  i++;
  if(i != 1){
    if($11 == state1 || $11 == state2){
      sum[$17] += $21
    }
  }
}END{
  for(i = 0;i<10;i++){
    curmin=999999.00;
    for(it in sum){
      if( sum[it] < curmin ){
        curmin = sum[it];
        min = it;
      }
    }
    ret[i] = min;
    sum[min] = 999999999.00;
  }
  for(it in ret) print ret[it];
}' Sample-Superstore.tsv
#bukan solusi paling elegan tapi bekerja
