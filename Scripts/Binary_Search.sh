#!/bin/bash

# Developer   : Vikas B Vooradi 
# Creation    : 20-10-2020
# Parameters  : P1 = <search_number>  P2 = <array_size>
# Purpose     : Write a Binary search program using shell script 

Binary_Search()
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
   
   # Calling Function : readInput to check the entered array values are vaild or not , if not the script will exit
   readInput $array_size 

   # It takes 2 parameters array size and search number. It only accept Integer number
   search_Number $array_size $snumber

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

# It reading array values as an Input from User and storing the Input values to the Dynamic array
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
   
   # Initial start value set to zero 
   start_value=0
   newLine
   echo "Start Value : $start_value"

   # Last end value is set to array size - 1
   end_value=`expr $array_size - 1` 
   newLine
   echo "End Value : $end_value"

   # Initial fail state set to zero 
   found=0
   
   while test "$start_value" -le "$end_value"
   do  
      
      # Calculating the Mid value 
      mid_value=`expr $start_value + $end_value / 2`
      newLine
      echo "Mid value : $mid_value"

      if [ "$snumber" = "${dynamic_array[$mid_value]}" ]
      then
           newLine
           array_index=`expr ${dynamic_array[$mid_value]} - 1`
           echo "Value found : ${dynamic_array[$mid_value]} in array list : ${dynamic_array[@]} at array index : $array_index "
           found=1
           return 0
      elif [ "$snumber" > "${dynamic_array[$mid_value]}"  ] 
      then
              start_value=`expr $mid_value  + 1`
      else
              end_value=`expr $mid_value -1 `
      fi         

   done 
   
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

Binary_Search $search_number $array_size

# ----------------------------------------------------------------------
# ----------------------------------------------------------------------

# Output 1 :
# $ sh Binary_search.sh

# BINARY SEARCH

# Please enter your search number : 3
# Please enter size of an array   : r

# Value    : 3 : is defined
# Value   : r : is defined
# Error : r is Not a number

# ----------------------------------------------------------------------
# ----------------------------------------------------------------------

# Output 2 :
# $ sh Binary_search.sh

# LINEAR SEARCH

# Please enter your search number : r
# Please enter size of an array   : 5

# Value    : r : is defined
# Error : r is Not a number

# ----------------------------------------------------------------------
# ----------------------------------------------------------------------

# Output 3 :
# $ sh Binary_search.sh

# LINEAR SEARCH

# Please enter your search number : 3

# Please enter size of an array   : 5

# Value    : 3 : is defined
# Value   : 5 : is defined

# Count of parameters matched 2 : 2

# Please enter 5 array values :

# ENTER ARRAY NUMBER - 0 : 1
# ENTER ARRAY NUMBER - 1 : 2
# ENTER ARRAY NUMBER - 2 : 3
# ENTER ARRAY NUMBER - 3 : 4
# ENTER ARRAY NUMBER - 4 : 5
# ENTER ARRAY NUMBER - 5 : 6

# Total size of Array : 6
# Array Values : 1 2 3 4 5 6
# Start Value : 0
# End Value : 4
# Mid value : 2

#Value found : 3 in array list : 1 2 3 4 5 6 at array index : 2

# ----------------------------------------------------------------------
# ----------------------------------------------------------------------

# Output 4 :
# $ sh Binary_search.sh

# LINEAR SEARCH

# Please enter your search number : 3
# Please enter size of an array   : 5

# Value    : 3 : is defined
# Value   : 5 : is defined

# Count of parameters matched 2 : 2

# Please enter 5 array values :

# ENTER ARRAY NUMBER - 0 : 1
# ENTER ARRAY NUMBER - 1 : 2
# ENTER ARRAY NUMBER - 2 : r
# Error : r is Not a number

# ----------------------------------------------------------------------
# ----------------------------------------------------------------------

# Output 5 :
# $ sh Binary_search.sh

# LINEAR SEARCH

# Please enter your search number : -2
# Please enter size of an array   : 5

# Value    : -2 : is defined
# Error : -2 is Not a number

# ----------------------------------------------------------------------
# ----------------------------------------------------------------------

# Output 6 :
# $ sh Binary_search.sh

# LINEAR SEARCH

# Please enter your search number : 3
# Please enter size of an array   : 5

# Value    : 3 : is defined
# Value   : 5 : is defined

# Count of parameters matched 2 : 2

# Please enter 5 array values :

# ENTER ARRAY NUMBER - 0 : 1
# ENTER ARRAY NUMBER - 1 : -2
# Error : -2 is Not a number

# ----------------------------------------------------------------------
# ----------------------------------------------------------------------
