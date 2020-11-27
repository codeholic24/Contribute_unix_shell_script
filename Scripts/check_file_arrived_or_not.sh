#!/bin/bash

MAX_TIME=20
counter=0
sleep=2

while true 
do 

export source_path='/e/FILES'
export destination_path='/e/DESTINATION_PATH'
file_name='ABC'
file_extension='txt'

[ -f $source_path/"$file_name" ]
status_1=$?

[ -f $source_path/"$file_name"."$file_extension" ]
status_2=$?

if [ "$status_1" == "0" ] && [ "$status_2" == "0" ]
then
     
     mv "$source_path"/$file_name*  $destination_path
     echo "Files moved successfully" 
     echo "Files moved successfully" >> $source_path/log.txt
     
     exit 0
else 
                         
                         update_counter=$(( counter + 1 )) 
                         echo "Updated counter : $update_counter" >> $source_path/log.txt

                         echo "Waiting for file ...$update_counter"  
                         echo "Waiting for file ...$update_counter" >> $source_path/log.txt

                         sleep 2s  
                         echo "sleep 2s" >> $source_path/log.txt

                         sleep=$(( sleep + 2 ))
                         echo "Added to sleep : $sleep" >> $source_path/log.txt

                         counter=$(( update_counter ))
                         echo "Counter updated : $counter" >> $source_path/log.txt

                         if [ "$sleep" == "$MAX_TIME"  ] 
                         then   
                               counter=0 
                               echo "Re set counter : $counter " >> $source_path/log.txt

                               sleep=0
                               echo "Re set sleep : $sleep" >> $source_path/log.txt

                               MAX_TIME=20     
                               echo "Re set max time : $MAX_TIME" >> $source_path/log.txt    
                               echo ""
                               echo "The program will halt for 20 s and then restart searching for file ..." 
                               echo "The program will halt for 20 s and then restart searching for file ..." >> $source_path/log.txt
                               sleep 20s
                
                               echo "#################################################################################" >> $source_path/log.txt 
                               echo "" >> $source_path/log.txt

                         fi           
                         
fi    

done 
