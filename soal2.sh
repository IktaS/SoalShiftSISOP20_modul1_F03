cat /dev/urandom | tr -cd 'a-zA-Z0-9' | fold -w 28 | head -n 1 > $1.txt
