# Reference : Stackoverflow : https://unix.stackexchange.com/questions/623132/check-if-first-character-is-the-same-as-the-last-character/623151#623151

#!/bin/bash
# GNU bash, version 4.4.20

str="abbba" 
firstchr=$(echo $str |  cut -c 1)
lastchr=$(echo $str  | rev | cut -c 1)

if [ "$firstchr" == "$lastchr"  ]
then
   echo "Yes, match"
else
   echo "No match"
fi
