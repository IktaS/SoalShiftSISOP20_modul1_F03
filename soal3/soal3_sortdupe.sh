kenloc=kenangan
duploc=duplicate

[ ! -d "$kenloc" ] && mkdir -p "$kenloc"
[ ! -d "$duploc" ] && mkdir -p "$duploc"


#3.c

grep 'Location: \|Saving to: ' wget.log | awk '{i++;if(i%2!=0) printf "%s ", $2;else print $3}' | tr -d "‘’" > location.log

lastkennum=`ls $kenloc/ | grep -c "kenangan_"`
lastdupnum=`ls $duploc/ | grep -c "duplicate_"`
awk -v lastkennum="$lastkennum" -v lastdupnum="$lastdupnum" -v kenloc="$kenloc" -v duploc="$duploc" -F " " '{
  map[$1]++;
  if(map[$1] > 1)
    {
      lastdupnum++;
      sh="mv "$2" "duploc"/duplicate_"lastdupnum;
    }
  else
    {
      lastkennum++;
      sh="mv "$2" "kenloc"/kenangan_"lastkennum;
    }
  system(sh)
}' location.log

mv wget.log wget.log.bak
mv location.log location.log.bak
