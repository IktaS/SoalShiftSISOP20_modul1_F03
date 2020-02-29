# SoalShiftSISOP20_modul1_B09
Soal shift Sistem Operasi 2020\
Modul 1\
Kelompok F03

## #1 &ndash; Pengolahan data Sample-Superstore.csv
> Source code: [soal1.sh](https://github.com/IktaS/SoalShiftSISOP20_modul1_F03/blob/master/soal1/soal1.sh)

---
 Soal 2 : baca file Sample-Superstore.tsv
 1.A   
  Diminta menentukan region dengan profit terendah\
 ```bash
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
  ```
  awalnya hitung i, agar bisa menskip baris pertama dengan\
  ```bash
  if(i!=1)
  ```
  lalu gunakan array untuk menyimpan total nilai profit( kolom 21 ), dan gunakan region ( kolom 13 ) untuk indexnya
  lalu pada\
  ```bash
  curmin=999999.00;
      for(it in sum){
        if( sum[it] < curmin ){
          curmin = sum[it];
          min = it;
        }
      }
      print min;
   ```
   digunakan untuk mencari nilai terkecil dari semua elemen array "sum", semua ini dimasukkan kedalam suatu variabel lowestreg untuk digunakan pada soal 1.b\
1.B  
  Diminta untuk mencari dua state dengan profit terendah berdasarkan hasil dari 1.A
  ```bash
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
    echo $twolowstate;
   ```
   Di sini variabel dari 1.A digunakan untuk mengerjakan, jadi di dalam awk perlu dipakai opsi
   ```bash
   awk -v lowestreg="$lowestreg
   ```
   agar ada variabel lowestreg yang bisa digunakan selama awk berjalan. Lalu, dicari dua nilai terkecil itu
    ```bash
        END{
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
      echo $twolowstate;
    ```
     lalu simpan semua hasil dalam sebuah variabel hasil twolowstate untuk dipakai di 1.C
  1.C
  Diminta mencari 10 nama produk dengan profit paling rendah dari hasil 1.B
   ```bash
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
  ```
  pertama variabel twolowstate dipassing kedalam array dengan
  ```bash
     arrstate=($twolowstate)
  ```
  dan diakses menjadi variabel di 
  ```bash
   awk -v state1="${arrstate[0]}" -v state2="${arrstate[1]}
  ```
  lalu dicari 10 nama produk dengan profit terkecil dengan
  ```bash
    END{
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
   ```
## #2 &ndash; Caesar Cipher
> Source code: [soal2.sh](https://github.com/IktaS/SoalShiftSISOP20_modul1_F03/blob/master/soal2/soal2.sh), [soal2_enkripsi.sh](https://github.com/IktaS/SoalShiftSISOP20_modul1_F03/blob/master/soal2/soal2_enkripsi.sh), [soal2_dekripsi.sh](https://github.com/IktaS/SoalShiftSISOP20_modul1_F03/blob/master/soal2/soal2_dekripsi.sh)

---

  2.A 
  Diminta membuat script yang bisa mengenerate alphanumeric random sepanjang 28 karakter dan disimpan ke text file dengan nama sesuai inputan
  ```bash
  cat /dev/urandom | tr -cd 'a-zA-Z0-9' | fold -w 28 | head -n 1 > $1.txt
  ```
  pertama mengakses string random dengan
  ```bash
  cat /dev/urandom
  ```
  lalu difilter hanya alphanumeric dengan
  ```bash
  tr -cd 'a-zA-Z0-9'
  ```
  lalu dipotong hanya menjadi 28 karakter dengan
  ```bash
  fold -w 28
  ```
  lalu dipotong hanya 1 baris
  ```bash
  head -n 1 
  ```
  lalu di simpan hasil semua itu ke nama txt sesuai input dengan
  ```bash
  > $1.txt
  ```
2.B 
Diminta membuat script yang bisa menenkripsi nama file dengan caesar cipher berdasarkan jam.  
  ```bash
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
  ```
  pertama ambil nama file saja dengan
  ```bash
  tempstring=`echo $1 | cut -d "." -f1`
  ```
  lalu cari jam sekarang dengan
  ```bash
  addnumber=`date +%H`
  ```
  baca character satu satu dengan
  ```bash
  for (( i=0; i<${#tempstring}; i++ )); do
   charascval=`echo "${tempstring:$i:1}"`
  ```
  ubah menjadi ascii dan tambahkan dengan jam dengan
  ```bash
  charascval=`printf "%d" "'$charascval"`
      charascval=`expr $charascval + $addnumber`
  ```
  lalu cek apakah hasil tambah lebih dari range alphabet, jika iya, loop balik dengan
  ```bash
  if [[ $charascval > 122 || $charascval > 90 ]]; then
        if [[ $charascval < 65 || $charascval < 97 ]]; then
          charascval=`expr $charascval - 26`
        fi
      fi
  ```
  lalu kembalikan kembali menjadi karakter dengan mengubah ke oktal dan print nilai character dalam oktal
  ```bash
   charascval=`echo "obase=8;$charascval"|bc`
      namestring=$namestring`echo -e "\\0$charascval"`
  ```
  lalu rename dengan
  ```bash
  mv $1 $namestring.txt
  ```
2.C 
Diminta membuat script yang bisa mendekripsi nama file dengan caesar cipher dan input parameter jam enkripsi.  
  ```bash
  namestring=""
  function csr_cipher() {
    tempstring=`echo $1 | cut -d "." -f1`
    addnumber=$2
    for (( i=0; i<${#tempstring}; i++ )); do
      charascval=`echo "${tempstring:$i:1}"`
      charascval=`printf "%d" "'$charascval"`
      charascval=`expr $charascval - $addnumber`
      if [[ $charascval > 122 || $charascval > 90 ]]; then
        if [[ $charascval < 65 || $charascval < 97 ]]; then
          charascval=`expr $charascval + 26`
        fi
      fi
      charascval=`echo "obase=8;$charascval"|bc`
      namestring=$namestring`echo -e "\\0$charascval"`
    done
  }
  csr_cipher $1 $2
  mv $1 $namestring.txt
  ```
  disini yang dilakukan sama persis, kecuali bagian penambahan nilai ascii menjadi pengurangan
  ```bash
  charascval=`expr $charascval - $addnumber`
  ```
  dan loop pengurangan menjadi penambahan
  ```bash
  charascval=`expr $charascval + 26`
  ```
  
## #3 &ndash; Cat
> Source code: [soal3.sh](https://github.com/IktaS/SoalShiftSISOP20_modul1_F03/blob/master/soal3/soal3.sh), [soal3_cron.txt](https://github.com/IktaS/SoalShiftSISOP20_modul1_F03/blob/master/soal3/soal3_cron.txt), [soal3_sortdupe.sh](https://github.com/IktaS/SoalShiftSISOP20_modul1_F03/blob/master/soal3/soal3_sortdupe.sh)

---

3.A  
  Diminta membuat script yang akan mendownload gambar dari suatu website sebanyak 28 kali dan memberi nama gambar tersebut "pdkt_kusuma_NO" dan menyimpan log filenya dalam bentuk wget.log.      
    
 ```bash
    if [[ `ls | grep -c "pdkt_kusuma_"` == 0 ]]; then
      lastnum=0
    else
      lastnum=$(ls | grep "pdkt_kusuma_" | cut -d "_" -f3 | sort -n | tail -1)
    fi
    for (( i = 1; i < 29; i++ )); do
      num=`expr $i + $lastnum`
      wget -O pdkt_kusuma_$num -a wget.log "https://loremflickr.com/320/240/cat"
    done
    ```
    pertama kita cek nomor file pdkt_kusuma_ yang ada dalam folder, agar penamaan bisa mengikuti dengan  
    ```bash
     if [[ `ls | grep -c "pdkt_kusuma_"` == 0 ]]; then
      lastnum=0
    else
      lastnum=$(ls | grep "pdkt_kusuma_" | cut -d "_" -f3 | sort -n | tail -1)
    fi
    ```
    lalu lakukan looping sebanyak 28 kali untuk mendownload dan memberi nama file, dan menaruh log di wget.log  
    ```bash
    for (( i = 1; i < 29; i++ )); do
      num=`expr $i + $lastnum`
      wget -O pdkt_kusuma_$num -a wget.log "https://loremflickr.com/320/240/cat"
    done
 ```
3.B  
  Diminta membuat cron job untuk menjalankan script tersebut setiap hari kecuali sabtu, setiap 8 jam mulai dari jam 06.05 pagi. 
  ```bash
    5 6,14,22 * * 1-5,7 bash /home/soal3.sh
  ```
3.C  
  Diminta membuat script yang bisa mensortir gambar yang sudah didownload berdasarkan apakah ada duplikat atau tidak, dan menaruhnya di folder tertentu dan memberi nama tertentu, lalu menyimpan semua log file dalam bentuk .log.bak.      
  ```bash
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
  ```
  pertama inisialisasi lokasi, dan cek lokasi jika sudah ada atau belum, jika belum, buat direktori
  ```bash
      kenloc=kenangan
      duploc=duplicate

      [ ! -d "$kenloc" ] && mkdir -p "$kenloc"
      [ ! -d "$duploc" ] && mkdir -p "$duploc"
  ```
  buat file location.log yang berisikan lokasi download dan nama file download, yang didapat dari memfilter wget.log
  ```bash
  grep 'Location: \|Saving to: ' wget.log | awk '{i++;if(i%2!=0) printf "%s ", $2;else print $3}' | tr -d "‘’" > location.log
  ```
  inisialisasi penomoran kenangan dan duplicate, lalu masukkan semua variabel di awk
  ```bash
      lastkennum=`ls $kenloc/ | grep -c "kenangan_"`
      lastdupnum=`ls $duploc/ | grep -c "duplicate_"`
      awk -v lastkennum="$lastkennum" -v lastdupnum="$lastdupnum" -v kenloc="$kenloc" -v duploc="$duploc" -F " "
  ```
  gunakan array untuk mencatat apakah sudah pernah ada location yang masuk, jika tidak, taruh di folder kenangan, dengan nama kenangan_NO,jika ada, taruh di folder duplicate dengan nama duplicate_NO
  ```bash
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
  ```
  ganti semua ekstensi .log ke .log.bak
  ```bash
    mv wget.log wget.log.bak
    mv location.log location.log.bak
  ```
  
