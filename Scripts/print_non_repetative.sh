Reference : https://unix.stackexchange.com/questions/618599/how-to-find-non-repetitive-letter-from-a-given-string/618614#618614

##################################################################################################################
Approach 1 : 

#Tested on below string

#String 1: aaabefhhhhhthkkd -> Output -> beftd

#String 2: AAAbefhhhhhThkkD -> Output -> befTD

#String 3: AAAbefhMThkkD -> Output -> befMTD

# String passed as an input 
str='aaabefhhhhhthkkd'

# Taking character count of provided string 
count=`echo "$str" | tr -cd '[a-z][A-z]' | wc -c`

# Dynamic array created 
dynamic_array=()

# Looping through the for loop 
for (( i=1 ; i<=$count ; i++ ))
{
    c=`echo "$str" |  cut -c $i`
    character_count=`echo "$str" | tr -cd $c | wc -c` 
    echo "Character : $c  : $character_count" 

   if [ $character_count -eq 1 ]
   then  
        dynamic_array+=("$c")   
   fi           
}

echo ""

# Printing characters stored in an array 
str_array_value=`echo ${dynamic_array[@]}`

# Replaced blank / space with none [squeez]
var=`echo $str_array_value | sed 's/[[:blank:]]//g'`
echo "Output : $var"

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



