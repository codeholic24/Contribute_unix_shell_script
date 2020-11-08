Reference : https://unix.stackexchange.com/questions/618599/how-to-find-non-repetitive-letter-from-a-given-string/618614#618614

##################################################################################################################
Approach 1 : This code submitted by me on above stackoverflow 

#!/bin/bash

# String passed as an input 
str='AAAbefhMThkkD'

# Taking character count of provided string 
count=$(echo "$str" | tr -cd 'a-z|A-Z' | wc -c)

# Dynamic array created 
dynamic_array=()

# Looping through the for loop 
for (( i=1 ; i<=$((count)) ; i++ ))
{
    c=$(echo "$str" |  cut -c "$i")
    character_count=$(echo "$str" | tr -cd "$c" | wc -c) 
    echo "Character : $c  : $character_count" 

   if [ "$character_count" -eq 1 ]
   then  
        dynamic_array+=("$c")   
   fi           
}

str_array_value="${dynamic_array[*]}" ; echo "Output : ${str_array_value// /}" 

# Input :  aaabefhhhhhthkkd : Output : beftd 
# Input :  AAAbefhhhhhThkkD : Output : befTD
# Input :  AAAbefhMThkkD    : Output : befMTD

##################################################################################################################

Approach 2 : 

echo "aaabefhhhhhthkkd" | fold -w1 | sort | uniq -u | paste -sd ''

##################################################################################################################

Approach 3 :
awk '{n=split($0,a,"");for(i=1;i<=n;i++)if(gsub(a[i],"")==1)printf("%s",a[i])}' <<< AAAbefhMThkkD

##################################################################################################################

Approach 4 :
echo "AAAbefhMThkkD" | sed '
  :1
  /\(.*\(.\).*\)\2/ { # while there is a duplicated char
    s//\2\1/; # move it to the front
    :2
      # remove characters that are the same as the first in a loop:
      s/^\(\(.\).*\)\2\{1,\}/\1/
    t2
    s/^.//
    b1
  }'
##################################################################################################################



