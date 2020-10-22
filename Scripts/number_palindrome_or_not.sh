#!/bin/bash

# Developer   : Vikas B Vooradi 
# Creation    : 22-10-2020
# Parameters  : P1 = <getNumber>
# Purpose     : Write a program using shell script to find duplicate in an array


palindrome()
{
  checkInuput $getNumber    
}

#To print a new line
newLine()
{
    echo ""
}

# Checking value is null or not 
checkInuput()
{
    [ -z $getNumber  ]
    status=$?

    if [ $status -ne 0 ]
    then
       newLine  
       echo "Value    : $getNumber : is defined"

       # Function : check_is_number_or_not : To check the entered value is Number or not 
       check_is_number_or_not $getNumber
       
       # Function : check_palindrome : To check the given value is palindrome or not 
       check_palindrome $getNumber     

    else
       newLine
       echo "Value    : is not defined...empty" 
       exit 0 
    fi   

}

# Function : check_is_number_or_not is created the check the given value is a Number or Not 
check_is_number_or_not()
{ 
   # Regex expression format for Integer re='^[0-9]+$'
   re='^[0-9]+$'
   if ! [[ $getNumber =~ $re ]] ; then
   newLine
   echo "Error : $getNumber is Not a number  " >&2; exit 1
   fi
}

# Function : check_palindrome checks the given number is a palindrome or not 
check_palindrome()
{

   newLine 
   original_number=$getNumber
   str_len=`echo ${#getNumber}`

   # Dynamic array declared
   dynamic_array=()

   echo -e "Your enterd Number : $getNumber \n" 
   
   for(( i=0 ; i<=$str_len ; i++ ))
   {  
      # getting charcater position values 
      get_position=`expr $str_len - $i` 
      get_val=`echo $original_number | cut -c'' $get_position 2>/dev/null`
      
      # Storing it to the values dynamically to an array 
      dynamic_array+=("$get_val")
   }
   
   # Printing the dynamic array values 
   str_array_value=`echo ${dynamic_array[@]}`
   echo "All array values : $str_array_value" 
   
   # squeeze all values 
   # (remove all spaces and treat it as one Value)
   squeeze=`echo $str_array_value  | tr -d "[:space:]"`
   newLine
   echo "Reverse Number : $squeeze"
   
   # Checking the Original Number with the Reverse Number 
   [ $original_number -eq $squeeze ] 
   status=$? 
   
   if [ $status -eq 0 ]
   then
       newLine
       echo -e "Number : $original_number is a Palindrome number"
   else 
       newLine
       echo -e "Number : $original_number is not a Palindrome number"
   fi

}

newLine
# Taking parameter from user and finding whether the number is palindrome or not
echo -n "Please enter the Number  : "; read getNumber
palindrome $getNumber

######################################################################################
#Output 1 :

#$ sh number_palindrome_or_not.sh

#Please enter the Number  : 45

#Value    : 45 : is defined
#Your enterd Number : 45
#All array values : 5 4
#Reverse Number : 54
#Number : 45 is not a Palindrome number

######################################################################################

#Output 2 :

# $ sh number_palindrome_or_not.sh

# Please enter the Number  : 545
# Value    : 545 : is defined
# Your enterd Number : 545
# All array values : 5 4 5
# Reverse Number : 545
# Number : 545 is a Palindrome number

######################################################################################

#Output 3 :

#$ sh number_palindrome_or_not.sh

#Please enter the Number  : rgh
#Value    : rgh : is defined
#Error : rgh is Not a number

######################################################################################

#Output 4 :

#$ sh number_palindrome_or_not.sh

#Please enter the Number  : -34
#Value    : -34 : is defined
#Error : -34 is Not a number

######################################################################################
