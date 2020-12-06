#!/bin/bash

MAX_TIME=20
counter=0
sleep=2

while true 
do 

export source_path='/e/TEST/Source_path'
export destination_path='/e/TEST/Destination_path'
export date_fldr=$(date +%Y-%m-%d)
export date_fldr_tme=$(date "+%Y-%m-%d-%H-%M-%S")

file_name='ABC'
file_extension='done'

[ -f $source_path/"$file_name" ]
status_1=$?

[ -f $source_path/"$file_name"."$file_extension" ]
status_2=$?

if [ "$status_1" == "0" ] && [ "$status_2" == "0" ]
then   
     mkdir -p $destination_path/$date_fldr/$date_fldr_tme 
     mv "$source_path"/$file_name* $destination_path/$date_fldr/$date_fldr_tme 
     echo "Files moved successfully" 
     echo ""
     #echo "Files moved successfully" >> $source_path/log_"$date_fldr".txt
     echo ""
else 
                         
                         update_counter=$(( counter + 1 )) 
                         #echo "" >> $source_path/log_"$date_fldr".txt
                         #echo "Updated counter : $update_counter" >> $source_path/log_"$date_fldr".txt
                   
                         #echo "" >> $source_path/log_"$date_fldr".txt
                         echo "Waiting for file ...$update_counter"  
                         #echo "Waiting for file ...$update_counter" >> $source_path/log_"$date_fldr".txt

                         sleep 2s  
                         #echo "" >> $source_path/log_"$date_fldr".txt
                         #echo "sleep 2s" >> $source_path/log_"$date_fldr".txt

                         sleep=$(( sleep + 2 ))
                         #echo "" >> $source_path/log_"$date_fldr".txt
                         #echo "Added to sleep : $sleep" >> $source_path/log_"$date_fldr".txt

                         counter=$(( update_counter ))
                         #echo "" >> $source_path/log_"$date_fldr".txt
                         #echo "Counter updated : $counter" >> $source_path/log_"$date_fldr".txt

                         if [ "$sleep" == "$MAX_TIME"  ] 
                         then   
                               counter=0 
                               #echo "" >> $source_path/log_"$date_fldr".txt
                               #echo "Re set counter : $counter " >> $source_path/log_"$date_fldr".txt

                               sleep=0
                               #echo "" >> $source_path/log_"$date_fldr".txt
                               #echo "Re set sleep : $sleep" >> $source_path/log_"$date_fldr".txt

                               MAX_TIME=20     
                               #echo "Re set max time : $MAX_TIME" >> $source_path/log_"$date_fldr".txt    
                               #echo "" >> $source_path/log_"$date_fldr".txt
                               echo "The program will halt for 20 s and then restart searching for file ..." 
                               #echo "The program will halt for 20 s and then restart searching for file ..." >> $source_path/log_"$date_fldr".txt
                               sleep 20s
                               #echo "" >> $source_path/log_"$date_fldr".txt
                               #echo "#################################################################################" >> $source_path/log_"$date_fldr".txt 
                               #echo "" >> $source_path/log_"$date_fldr".txt

                         fi           
                         
fi    

done 
