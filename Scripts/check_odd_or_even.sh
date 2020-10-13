#!/bin/bash

# Developer   : Vikas B Vooradi 
# Creation    : 12-10-2020
# Parameters  : <InputNumber>
# Purpose     : Check the given number is even or odd 

# Scenario 
# case 1 : if number is positive then find it is even or odd
# case 2 : if number is negative convert it to positive and find it is even or odd
# case 3 : if its a floating number , maybe negative [-2.5] or postive [4.5] exit the process with a msg
# Note   : This all sceanrio should be covered in only one script 

check_odd_or_even()
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
       echo "Number  : $getNumber : is not defined" 
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

   check_isInteger_or_decimal $getNumber
   check_positive_number $getNumber
   
}

# calcuate_it function will calculate the number is even or odd
calculate_it()
{
    rem=$(( $getNum % 2 ))
 
    if [ $rem -eq 0 ]
    then
        echo "Number : $getNum is a even number"
    else
        echo "Number : $getNum is a odd number"
    fi
}

# calling function to check number is positive or negative 
check_positive_number()
{
    getNum=`echo $getNumber`
    
    if [ $getNumber -gt 0 ]  || [ $getNumber -eq 0  ]
    then
         echo "It is a positive number"
         echo "Calling function to calculate even or odd"
         calculate_it $getNum
    else      
         echo "It is not a positive number"
         swap_negative_to_positive $getNum
         exit 1
    fi
}

 swap_negative_to_positive will swap the number from negative to positive
 swap_negative_to_positive()
 {
    if [ $getNum -lt 0 ]
    then 
        echo "Converting negative number to postive number"
        getNum=`echo $getNum | tr -d '-'`
        calculate_it $getNum
    fi    
 }

# Check value is decimal or not
check_isInteger_or_decimal()
{
    real_num=$getNumber
    swap_it=`echo $getNumber | tr -d '-'` 
    getNumber=$swap_it
        
    echo "$getNumber" | grep "^[0-9]*[.][0-9]*$"  
    status=`echo $?`
    if [[ $status == 0 ]]
    then
        echo "It is float number .. cannot continue : $real_num"
        echo "The script will not process if it's a decimal number or having negative sign to decimal number"
        exit 1
    else
        echo "No issue with the provided number : $getNumber"
    fi
}

# Calling function : 1 parameters is intialized 
# Note : If you want to test just replace the parameters with your parameters 
check_odd_or_even 2.0

#Output 

#parameter is passsed as like following :  check_odd_or_even 1
#$ sh check_odd_or_even.sh
#  Number  : 1 : is defined
#  Count of parameters matched 1 : 1
#  No issue with the provided number : 1
#  It is a positive number
#  Calling function to calculate even or odd
#  Number : 1 is a odd number

#parameter is passsed as like following :  check_odd_or_even 2
#$ sh check_odd_or_even.sh
#  Number  : 2 : is defined
#  Count of parameters matched 1 : 1
#  No issue with the provided number : 2
#  It is a positive number
#  Calling function to calculate even or odd
#  Number : 2 is a even number

#parameter is passsed as like following :  check_odd_or_even -2
#$ sh check_odd_or_even.sh
#  Number  : 2 : is defined
#  Count of parameters matched 1 : 1
#  No issue with the provided number : 2
#  It is a positive number
#  Calling function to calculate even or odd
#  Number : 2 is a even number

#parameter is passsed as like following :  check_odd_or_even -2.0
#$ sh check_odd_or_even.sh
# check_odd_or_even.sh: line 69: swap_negative_to_positive: command not found
# Number  : -2.0 : is defined
# Count of parameters matched 1 : 1
# 2.0
# It is float number .. cannot continue : -2.0
# The script will not process if it's a decimal number or having negative sign to decimal number

#parameter is passsed as like following :  check_odd_or_even 2.0
#$ sh check_odd_or_even.sh
#  check_odd_or_even.sh: line 69: swap_negative_to_positive: command not found
#  Number  : 2.0 : is defined
#  Count of parameters matched 1 : 1
#  2.0
#  It is float number .. cannot continue : 2.0
#  The script will not process if it's a decimal number or having negative sign to decimal number
