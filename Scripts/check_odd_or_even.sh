#!/bin/bash

# Developer   : Vikas B Vooradi 
# Creation    : 12-10-2020
# Parameters  : <InputNumber>
# Purpose     : Check the given number is even or odd 

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

   check_positive_number $getNumber
   
}

# calcuate_it function will calculate the number is even or odd
calculate_it()
{
    rem=$(( $getNum % 2 ))
 
    if [ $rem -eq 0 ]
    then
        echo "Number : $getNum is even number"
    else
        echo "Number : $getNum is odd number"
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
    fi
}

# swap_negative_to_positive will swap the number from negative to positive
swap_negative_to_positive()
{
    if [ $getNum -lt 0 ]
    then 
        echo "Converting negative number to postive number"
        getNum=`echo $getNum | tr -d '-'`
        calculate_it $getNum
    fi    
}

# Calling function : 1 parameters is intialized 
# Note : If you want to test just replace the 1 parameters with your parameters 
check_odd_or_even -5
