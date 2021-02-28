#!/bin/sh

cleanup()
{
  rm -rf "$PATH_LOGFILE"/Log*.txt
}

CheckingConnection()
{

#Pre-defined parameters 
PATH_LOGFILE='/f/ORACLE_AUTO_GEN'
DT=$(date +"%m-%d-%y")
ERRCODES="(ORA-|EXP-|IMP-|KUP-|MOD-|PLS-|SP2-|SQL-|TNS-)"

cd $PATH_LOGFILE || exit
rm -rf $PATH_LOGFILE/TempLog"_""$DT".txt 

#Checking connection establishment : Username/Password@host:port/Servicename 
sqlplus -s -S 2>&1 >> $PATH_LOGFILE/Log"_""$DT".txt << EOF
ABC/ABC@localhost:1XXX/ABC
set heading off verify off feedback off echo off term off pagesize 0 linesize 10000 trimout on trimspool on timing off 
  select * from dual;
  exit;
EOF

#Copying log to temp log file 
cp $PATH_LOGFILE/Log"_""$DT".txt $PATH_LOGFILE/TempLog"_""$DT".txt 

#Grepping the errr code to check for ERROR  
ERRC=$(grep -E "${ERRCODES}" $PATH_LOGFILE/Log"_""$DT".txt | wc -c) 

#Checking status
status=$?
if [ "$ERRC" -eq 0 ]
then
 
    echo "Connection established successfully ..."
    cleanup

else

    printf 'ERROR:\t%s\n' "Something went wrong"
    grep -w "ERROR" $PATH_LOGFILE/Log"_""$DT".txt > /dev/null
    status=$?
    if [ $status -eq 0 ]
    then 
        grep -E "${ERRCODES}" $PATH_LOGFILE/Log"_""$DT".txt | uniq -u 
        cleanup
    else
        echo "Nothing to do..."
    fi        

fi 

}

CheckingConnection


