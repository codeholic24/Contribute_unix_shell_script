

#!/bin/bash

# Developer   : Vikas B Vooradi 
# Creation    : 11-10-2020
# Parameters  : <Input_filename> <pipe/comma_separated> <cut_specific_row> <Output_filename>
# Purpose     : Print the specific pipe separated row data to Vertical format 

# Explanation :

#Q1 : How to print specific pipe separate row data in vertical format ?

#for example : 

#Data will be in file like below. you just need to pick 
#specific row and convert into vertical format 

#if i pick 2nd row then entire data which is in second 
#row sould be printed in vertical format like output 
#mentioned below

#DATA FILE :
#1|mumbai|vikky|CSC
#2|delhi|darshan|MBA
#3|orissa|raj|MMS

#OUTPUT :
#2
#delhi
#darshan
#MBA

convert_pipe_separated2vertical ()
{
   # Input file name which you want to convert
   # example : Input_filename='/path/filename.txt'

   Input_filename=$1
   
   # Input symbol like ","  or "|"  -> This may be taken according to the data inside the file 
   Input_symbol=$2

   # Mention specific row number where you want to perform vertical format operation
   # example : if i mention 2 then it will cut second row and perform vertical format operation
   cut_specific_row=$3
   
   # Output file name where converted data is stored
   # example : Output_filename='/path/Output_filename.txt'
   Output_filename=$4

   [ -z $Input_filename ]
   status=$?

   if [ $status -ne 0 ]
   then
       echo "INPUT FILE NAME  : $Input_filename - is defined"
   else
       echo "INPUT FILE NAME  : $Input_filename - is not defined"  
   fi    

   [ -z $Input_symbol ]
   status=$?

   if [ $status -ne 0 ]
   then
       echo "SYMBOL           : $Input_symbol - is defined"
   else
       echo "SYMBOL           : $Input_symbol - is not defined"  
       exit 0
   fi 

   [ -z $cut_specific_row ]
   status=$?
 
   if [ $status -ne 0 ]
   then
       echo "SPECIFIC ROW     : $cut_specific_row - is defined"
   else
       echo "SPECIFIC ROW     : $cut_specific_row - is not defined"  
       exit 0
   fi 
   
   [ -z $Output_filename ]
   status=$?

   if [ $status -ne 0 ]
   then
       echo "OUTPUT FILE NAME : $Output_filename - is defined"
   else
       echo "OUTPUT FILE NAME : $Output_filename - is not defined"  
       exit 0
   fi 

   # checking the parameters entered are matching or not 
   if [ "$#" -eq 4 ] 
   then
   echo "Count of parameters matched `echo $#` : 4 " 
   else 
   echo "Illegal number of parameters passed.Expected parameters are 4 ..try again"
   exit 0
   fi

   # Checking converting file exist or not 
   [ -f $Input_filename ] 
   status=$?

   if [ $status -eq 0 ]
   then 

   echo "File : $Input_filename exist"

   # checking file as data or not 
   if [ -s ${Input_filename} ]
   then

        echo "File  : $Input_filename as Data"
   
        # Reading specific row data into a temporary variable  
        read_data=`sed -n "${cut_specific_row}"p $Input_filename`

        # Using temporary variable in processing for vertical format 
        echo $read_data | tr '|' '\n' > $Output_filename
        status=$?
      
        if [ $status -eq 0 ]
        then
            echo "File name : $Input_filename is converted successfully to vertical format and output is in : $Output_filename "
        else
            echo "File name : $Input_filename is fail to convert into vertical format"
            exit 0
        fi 
        
        else
            echo "$Input_filename is empty"
            exit 0   
        fi 

    else     
        echo "File : $Input_filename does not exist"
        exit 0
    fi 

}

# Calling function : 4 parameters are intialized 
convert_pipe_separated2vertical '/f/Test.txt' '|' 2 '/f/Output.txt'

# Note : If you want to test just replace the 4 parameters with your parameters 
