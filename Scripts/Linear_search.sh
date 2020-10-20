#!/bin/bash

# Developer   : Vikas B Vooradi 
# Creation    : 18-10-2020
# Parameters  : P1 = <search_number>  P2 = <array_size>
# Purpose     : Write a Linear search program using shell script 

Linear_Search()
{

   # Intializing the value 
   getNumber=$1
   array_size=$2

   # stored in variable to make use of it in function as an when required
   snumber=$getNumber 

   # checking value entered is null or not  
   [ -z $getNumber ]
   status=$?

   if [ $status -ne 0 ]
   then
       newLine  
       echo "Value    : $getNumber : is defined"

       # Function : check_is_number_or_not is called to check the entered value is number or not
       check_is_number_or_not $getNumber  
   else
       newLine
       echo "Value    : is not defined...empty" 
       exit 0 
   fi 

   # checking value entered is null or not  
   [ -z $array_size ]
   status=$?

   if [ $status -ne 0 ]
   then
       newLine
       echo "Value   : $array_size : is defined"
       
       # To make function reusable , I have just taken the $array_size to a variable : getNumber
       # Becasue the function expecting the getNumber variable 
       getNumber=$array_size 

       # Function : check_is_number_or_not is called to check the entered value is number or not
       check_is_number_or_not $getNumber  
   else
       newLine
       echo "Value    : is not defined...empty" 
       exit 0 
   fi 

   # checking the parameters entered are matching or not 
   if [ "$#" -eq 2 ] 
   then
   newLine
   echo "Count of parameters matched `echo $#` : 2 " 
   else 
   newLine
   echo "Illegal number of parameters passed.Expected parameters are 2 ..try again"
   exit 0
   fi
   
   # Calling Function : readInput to check the entered array values are vaild or not , if not the script with exit
   readInput $array_size 

   # Calling Function : To search the given value in the array list 
   search_Number $snumber

}

# Function : check_is_number_or_not is created the check the given value is a Number or Not 
check_is_number_or_not()
{
   re='^[0-9]+$'
   if ! [[ $getNumber =~ $re ]] ; then
   newLine
   echo "Error : $getNumber is Not a number  " >&2; exit 1
   fi
}

# To Print the echo statement on a new line 
newLine()
{
    echo ""
}

# It reading array values as an Input from User 
readInput()
{
   dynamic_array=()

   newLine 
   echo "Please enter $array_size array values : "
   
   for (( i=0 ; i<=$array_size ; i++ ))
   { 
      newLine 
      echo -n "ENTER ARRAY NUMBER - $i : " ; read array_number
      getNumber=$array_number
      check_is_number_or_not $getNumber
      dynamic_array+=("$getNumber")
   }
   
}

# It searches the entered values in the Array list to find if its exist or Not 
search_Number()
{
   newLine 
   # Print total size of an array  
   echo Total size of Array : ${#dynamic_array[@]}
   
   newLine
   # Print all array values 
   echo Array Values        : ${dynamic_array[@]}

   # Stores the array size in variable    
   strnumber=${#dynamic_array[@]}
    
   # Initial state setting it as zero : Not found 
   found=0

   # Linear search : Logic defined , It iterates all the values one by one and find for values exist in an array or not 
   for (( i=0 ; i<=$strnumber ; i++  ))
   {
       getval=`echo ${dynamic_array[i]}`
       if [ "$getval" = "$snumber" ]
       then 
           newLine
           echo "Value found : $snumber in array list : ${dynamic_array[@]} "
           found=1
           break
       fi       
   }

   #It returns status , fail or success
   if [ $found -eq 0  ]
   then
       newLine
       echo "Number : $snumber does not exist in an array"
   fi 

}


echo -e "\nLINEAR SEARCH"

newLine

#Reading number which need to search in an array 
echo -n "Please enter your search number : "; read search_number
newLine
echo -n "Please enter size of an array   : "; read array_size


# The below defined function takes two paramters parameter 1 : search number & parameter 2 : array size 
# search number :  It contains a number which we want to find in the array list present or not 
# array size    :  It contain size of an array ie : number of elements will be their in an array 

Linear_Search $search_number $array_size

# -----------------------------------------------------------------
# -----------------------------------------------------------------

# Output 1 :
# $ sh Linear_search.sh

# LINEAR SEARCH
# Please enter your search number : 55
# Please enter size of an array   : 4
# Value    : 55 : is defined
# Value   : 4 : is defined
# Count of parameters matched 2 : 2
# Please enter 4 array values :

# ENTER ARRAY NUMBER - 0 : 23
# ENTER ARRAY NUMBER - 1 : 45
# ENTER ARRAY NUMBER - 2 : 55
# ENTER ARRAY NUMBER - 3 : 23
# ENTER ARRAY NUMBER - 4 : 89

# Total size of Array : 5
# Array Values : 23 45 55 23 89
# Value found : 55 in array list : 23 45 55 23 89

# -----------------------------------------------------------------
# -----------------------------------------------------------------

# Output 2 :
# $ sh Linear_search.sh

# LINEAR SEARCH
# Please enter your search number : r
# Please enter size of an array   : 5
# Value    : r : is defined
# Error : r is Not a number

# -----------------------------------------------------------------
# -----------------------------------------------------------------

# Output 3 :
# $ sh Linear_search.sh

# LINEAR SEARCH
# Please enter your search number : 45
# Please enter size of an array   : f
# Value    : 45 : is defined
# Value   : f : is defined
# Error : f is Not a number

# -----------------------------------------------------------------
# -----------------------------------------------------------------

# Output 4 :
# $ sh Linear_search.sh

# LINEAR SEARCH
# Please enter your search number : 77
# Please enter size of an array   : 3
# Value    : 77 : is defined
# Value   : 3 : is defined

# Count of parameters matched 2 : 2

# Please enter 3 array values :

# ENTER ARRAY NUMBER - 0 : 23
# ENTER ARRAY NUMBER - 1 : 45
# ENTER ARRAY NUMBER - 2 : 67
# ENTER ARRAY NUMBER - 3 : dd
# Error : dd is Not a number

# -----------------------------------------------------------------
# -----------------------------------------------------------------

# Output 5 :

# $ sh Linear_search.sh

# LINEAR SEARCH

# Please enter your search number : 32
# Please enter size of an array   : 3
# Value    : 32 : is defined
# Value   : 3 : is defined

# Count of parameters matched 2 : 2

# Please enter 3 array values :

# ENTER ARRAY NUMBER - 0 : 22
# ENTER ARRAY NUMBER - 1 : 56
# ENTER ARRAY NUMBER - 2 : 78
# ENTER ARRAY NUMBER - 3 : 90

# Total size of Array : 4
# Array Values : 22 56 78 90
# Number : 32 does not exist in an array

# -----------------------------------------------------------------
# -----------------------------------------------------------------

# Output 6 :

# $ sh Linear_search.sh

# LINEAR SEARCH

# Please enter your search number : 3
# Please enter size of an array   : 5

# Value    : 3 : is defined
# Value   : 5 : is defined

# Count of parameters matched 2 : 2

# Please enter 5 array values :

# ENTER ARRAY NUMBER - 0 : 1
# ENTER ARRAY NUMBER - 1 : 2
# ENTER ARRAY NUMBER - 2 : -4
# Error : -4 is Not a number

# -----------------------------------------------------------------
# -----------------------------------------------------------------
