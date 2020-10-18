#!/bin/bash

# Developer   : Vikas B Vooradi 
# Creation    : 18-10-2020
# Parameters  : <InputNumber>
# Purpose     : Write a Linear search program using shell script 

Linear_Search()
{

   # Intializing the value 
   getNumber=$1

   # checking value entered is null or not  
   [ -z $getNumber ]
   status=$?

   if [ $status -ne 0 ]
   then
       echo "Number  : $getNumber : is defined"
   else
       echo "Number  : is not defined...empty" 
       exit 0 
   fi 

   # checking the parameters entered are matching or not 
   if [ "$#" -eq 1 ] 
   then
   echo "Count of parameters matched `echo $#` : 1 " 
   else 
   echo "Illegal number of parameters passed.Expected parameters are 1 ..try again"
   exit 0
   fi

   search_number_in_array $getNumber
 
}

search_number_in_array()
{

   # Defined array
   arr=([0]=2 [1]=5 [2]=19 [3]=20 [4]=4 [5]=54) 
   strnumber=${#arr[@]}
   found=0 
   
   # Checking its number or not 
   check_is_number_or_not $getNumber

   # Printing count of elements present in an array
   echo "Count of elements present : ${#arr[@]}"

   for (( i=0 ; i<=$strnumber ; i++  ))
   {
       getval=`echo ${arr[i]}`
       if [ "$getval" = "$getNumber" ]
       then 
           echo "Value found : $getNumber"
           found=1
           break
       fi       
   }

   if [ $found -eq 0  ]
   then
       echo "Number does not exist in an array"
   fi    

}

check_is_number_or_not()
{
   re='^[0-9]+$'
   if ! [[ $getNumber =~ $re ]] ; then
   echo "error: Not a number" >&2; exit 1
   fi
}

echo -e "\nLINEAR SEARCH"
echo ""

#Reading number which need to search in an array 
echo -n "Please enter your number : "; read number
Linear_Search $number

