#!/bin/bash

# Developer   : Vikas B Vooradi 
# Creation    : 20-10-2020
# Parameters  : P1 = <array_size>
# Purpose     : Write a program to find duplicate value in a array using shell script


#########################################################################################

# Explanation :

# tr      : tr [ Translate ] - It is a useful command line utility for manipulating text 
# -d      : flag to delete characters
# \n      : Print text on new line  
# sort -n : Sort text/line in ascending order
# uniq -d : It only prints the repeated lines or text

#########################################################################################

find_duplicate()
{
  # calling function
  # To make reusable of check_is_number_or_not , I have initialized the array_size value into
  # a new variable called : getNumber  
  getNumber=$array_size

  # Function : checkInuput is called which takes the parameter wich is created above getNumber
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

       # Function : readInput : Reading array values from user upto the defined array size  
       readInput $getNumber

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

readInput()
{
   # Dynamic array created 
   dynamic_array=()

   newLine 
   echo "Please enter $array_size array values"
   
   for (( i=0 ; i<=$array_size ; i++ ))
   { 
      newLine 
      echo -n "ENTER ARRAY NUMBER - $i : " ; read array_number
      getNumber=$array_number
      check_is_number_or_not $getNumber
      dynamic_array+=("$getNumber")
   }

   newLine
   # Print all array values 
   str_array_value=`echo ${dynamic_array[@]}`

   # Sorting and printing only duplicate value and storing to a variable
   print_duplicate=`echo $str_array_value | tr ' ' '\n' | sort -n | uniq -d`
   
   newLine
   echo "Duplicate values in given array list : $str_array_value "
   newLine
   echo $print_duplicate

}

newLine
echo -n "Please enter size of an array   : "; read array_size

# Main function is called with one paramter array_size
# array size    :  It contain size of an array ie : number of elements will be their in an array 

find_duplicate $array_size

########################################################
# Output 1 : 
# $ sh display_duplicate_array_num.sh
# Please enter size of an array   : r
# Value    : r : is defined
# Error : r is Not a number

########################################################

# Output 2 : 
# $ sh display_duplicate_array_num.sh

# Please enter size of an array   : 5
# Value    : 5 : is defined

# Please enter 5 array values

# ENTER ARRAY NUMBER - 0 : 2
# ENTER ARRAY NUMBER - 1 : 5
# ENTER ARRAY NUMBER - 2 : 3
# ENTER ARRAY NUMBER - 3 : 6
# ENTER ARRAY NUMBER - 4 : r

# Error : r is Not a number

########################################################

# Output 3 :

# $ sh display_duplicate_array_num.sh

# Please enter size of an array   : 5
# Value    : 5 : is defined

# Please enter 5 array values

# ENTER ARRAY NUMBER - 0 : 2
# ENTER ARRAY NUMBER - 1 : 3
# ENTER ARRAY NUMBER - 2 : 5
# ENTER ARRAY NUMBER - 3 : 6
# ENTER ARRAY NUMBER - 4 : 4
# ENTER ARRAY NUMBER - 5 : 3

# Duplicate values in given array list : 2 3 5 6 4 3
# 3

########################################################

# Output 4 :

# $ sh display_duplicate_array_num.sh

# Please enter size of an array   : 5
# Value    : 5 : is defined

# Please enter 5 array values

# ENTER ARRAY NUMBER - 0 : 2
# ENTER ARRAY NUMBER - 1 : 4
# ENTER ARRAY NUMBER - 2 : 6
# ENTER ARRAY NUMBER - 3 : -1

# Error : -1 is Not a number

########################################################
