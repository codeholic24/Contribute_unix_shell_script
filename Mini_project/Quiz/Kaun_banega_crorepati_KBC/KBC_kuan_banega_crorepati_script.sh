#!/bin/bash

# Developer   : Vikas B Vooradi 
# Creation    : 12-10-2020
# linkedin    : https://www.linkedin.com/in/vikas-bhaskar-vooradi/

# Exporting the parameters from parameter file
. /f/Contribute_unix_shell_script/Kaun_banega_crorepati_KBC/Parameter

# This function is the heart of the script 
Welcome_screen() 
{
    Clr
    cat $Ws
    check_file_count
    fetch_Option_set
}

# This function helps in switching the screen
switch_screen()
{
    cat $Ws
}

# This function is used to Clear screen 
Clr()
{
    clear
}

# This function helps in editing Question set file 
Edit_Question_set()
{
   vim $Qs
}

# This function helps in editing Answer set file 
Edit_Answer_set()
{
   vim $As
}

# This function helps in editing Option set file 
Edit_Option_set()
{
    vim $Os
}

# This function handles the Question set , Answer set and Option set file count 
check_file_count()
{
    Question_count=`cat $Qs | sed '/^\s*#/d;/^\s*$/d' | wc -l`
    Answer_count=`cat $As | sed '/^\s*#/d;/^\s*$/d' | wc -l`
    Option_count=`cat $Os |  sed '/^\s*#/d;/^\s*$/d' | wc -l`

    if [ "$Question_count" -ne  "$Answer_count" ]   
    then
       newLine
       echo "Process 1 : if condiiton failed" 
       echo "Question_set : $Question_count"
       echo "Answer_set   : $Answer_count"
       echo "Count should be similar accross all the set"
       echo "exiting ... "
       exit 0  
    fi

    if [ "$Question_count" -ne  "$Option_count" ]
    then
       newLine
       echo "Process 2 : if condiiton failed" 
       echo "Question_set : $Question_count"
       echo "Option_set   : $Option_count"
       echo "Count should be similar accross all the set"
       echo "exiting ... "
       exit 0  
    fi

    if [ "$Answer_count" -ne  "$Option_count" ]
    then
       newLine
       echo "Process 3 : if condiiton failed"     
       echo "Answer_set   : $Answer_count"
       echo "Option_set   : $Option_count"
       echo "Count should be similar accross all the set"
       echo "exiting ... "
       exit 0  
    fi

    if [ "$Answer_count" -ne  "$Question_count" ]
    then
       newLine
       echo "Process 4 : if condiiton failed"     
       echo "Answer_set   : $Answer_count"
       echo "Question_set : $Question_count"       
       echo "Count should be similar accross all the set"
       echo "exiting ... "
       exit 0  
    fi

    if [ "$Option_count" -ne  "$Question_count" ]
    then
       newLine
       echo "Process 5 : if condiiton failed"     
       echo "Option_set   : $Option_count"    
       echo "Question_set : $Question_count"
       echo "Count should be similar accross all the set"
       echo "exiting ... "
       exit 0  
    fi

    if [ "$Option_count" -ne  "$Answer_count" ] 
    then
       newLine 
       echo "Process 6 : if condiiton failed"     
       echo "Option_set   : $Option_count" 
       echo "Answer_set   : $Answer_count"
       echo "Count should be similar accross all the set"
       echo "exiting ... "
       exit 0  
    fi

    export Total_cnt=$Question_count

}

# This function is used to fetch references I refered to build this script
getReference()
{
   cat $Rf
}


#This function is used to fetch money earned so far by the user
fetch_win_money()
{
   read_counter=$1
   read_win_cash=$2
   newLine
   echo -n "The Amount you earned :  $(( $read_counter * $read_win_cash ))"

}


#This is countdown which display the countdown timer to the user , its like alert 
#You have this many seconds left to answer your question otherwise ..time out error occur's
countdown()
{

total=20  
count=0  
while [ ${count} -lt ${total} ] ; do
    tlimit=$(( $total - $count ))
    echo -e "\rYou have ${tlimit} seconds to enter your answer: \c"
    read -t 1 readUserInput 
    test ! -z "$readUserInput" && { break ; }
    count=$((count+1))
done

if [ ! -z "$readUserInput" ] ; then
    newLine
    export readUserInput=$readUserInput
else
    echo -e "Time out..sorry try again"
    if [ $outer_incr -eq 1 ]
    then 
          echo "The Amount you earned : 0"
    else
         inc_decr=$(( $outer_incr - 1 ))
         fetch_win_money $inc_decr  10  
    fi           

    exit 1
fi

}

#This function is created to check the Answer eneterd by user does it match with Answer set or not 
#If it matches then displays the score and moves to next question
#Switch case handles all the logic   
readInput()
{
    readUserInput=$1
    readUsercnt=$2

    case $readUserInput in 

    A|B|C|D|a|b|c|d) 
             echo "Processing your answer"
             ans=`sed -n "$readUsercnt"p $As | cut -d',' -f1`
             if [ "$readUserInput" == "$ans" ]
             then 
                 newLine
                 echo "Aap ka Jaavab sahi hn ..."
                 fetch_win_money $outer_incr 10
                 newLine
             else
                 newLine
                 echo "Sorry Aap ka jaavab sahi nhi hn ... well played"
                 newLine
                 outer_incr=$(( $outer_incr - 1 ))
                 fetch_win_money $outer_incr  10
                 newLine
                 exit 0
             fi         
    ;;

    [0-9]|*)
         newLine
         echo "Sorry you have entered invalid option ...press A or B or C or D"
         exit 1

    esac
}

# Print new line as an when required in program
newLine()
{

    echo ""
}

fetch_Option_set()
{
    echo "Lets play Kaun_banega_crorepati_KBC" | sed  -e :a -e 's/^.\{1,145\}$/ & /;ta'
    echo "hum aur aap khelte hn kaun banega crorepati ...." | sed  -e :a -e 's/^.\{1,158\}$/ & /;ta'
    echo "shuroo kiya jaaye" | sed  -e :a -e 's/^.\{1,127\}$/ & /;ta'
    newLine
    echo "Your time start now .... sirf aap k paas 20 seconds hn har ek question k leye" | sed  -e :a -e 's/^.\{1,175\}$/ & /;ta'
    sleep 5s
    outer_incr=1
    until [ $outer_incr -gt $Total_cnt ] 
    do 

        inner_incr=1
        until [ $inner_incr -gt $Total_cnt ]
        do 

            if [ $outer_incr -eq $inner_incr ]   
            then  
                 newLine    
                 echo "Your Question : $outer_incr on Screen" 
                 newLine 
                 echo "You have only 20 seconds to answer ..."
                 newLine
                 sleep 1s
                 sed -n "$outer_incr"p $Qs
                 newLine
                 sed -n "$outer_incr"p $Os                 
                 newLine
                 countdown 
                 echo "Computer ji javaab lock keya jaaye....."
                 newLine 
                 readInput $readUserInput $outer_incr
                 sleep 2s    
                 export outer_incr=$outer_incr  
                 clear 
                 switch_screen                                         
            fi

            inner_incr=`expr $inner_incr + 1` 

        done
        
        outer_incr=`expr $outer_incr + 1` 

        echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

    done
  
}


echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
newLine
echo " [1] Let's start the GAME" | sed  -e :a -e 's/^.\{1,150\}$/ & /;ta'
echo " [2] Edit Question set" | sed  -e :a -e 's/^.\{1,147\}$/ & /;ta'
echo " [3] Edit Answer set" | sed  -e :a -e 's/^.\{1,145\}$/ & /;ta'
echo " [4] Edit Option set" | sed  -e :a -e 's/^.\{1,145\}$/ & /;ta'
echo " [5] Reference" | sed  -e :a -e 's/^.\{1,138\}$/ & /;ta'
echo " [6] Exit" | sed  -e :a -e 's/^.\{1,134\}$/ & /;ta'
newLine
echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -n "Choose the option you want to go for ... : " | sed  -e :a -e 's/^.\{1,100\}$/ & /;ta'
read option

case $option in 

1) 
    # This function calls Main Screen
    Welcome_screen
;;

2) 
    # This function calls Question set file where you can edit the Question or add new Question 
    # Note : The Total number of Question you entered here the count should match with Option and Answer set file 
    Edit_Question_set
;;

3)
    # This function calls Answer set file where you can edit the Answer or add new Answer 
    # Note : The Total number of Answer you entered here the count should match with Question and Option set file 
    Edit_Answer_set 
;;

4) 
    # This function calls Option set file where you can edit the Option or add new Option 
    # Note : The Total number of Option you entered here the count should match with Question and Answer set file 
    Edit_Option_set
;;

5)
    #Here you will get to see all reference link which I have refered to build this KBC script 
    getReference
;;

6 | * )
    exit 0  
 
esac

