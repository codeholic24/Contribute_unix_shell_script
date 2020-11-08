#Reference : https://unix.stackexchange.com/questions/612993/how-to-print-every-nth-character-of-a-string

echo "abcdefghijklmnopqrstuvwxyz" | sed -E 's/(.).{0,1}/\1/g'

# Output :  acegikmoqsuwy
