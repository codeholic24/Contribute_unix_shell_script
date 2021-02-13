########################################################################################################################################
#Reference stackoverflow : https://stackoverflow.com/questions/66171608/how-to-print-before-and-after-dot-text-unix/66171742#66171742
#Visit the above link to find more commands How to achieve the expected output 
#All credit goes to the respective user who as shared their solution for my posted question on stackoverflow
########################################################################################################################################

#How to print before and after dot text Unix ? 

InputVar="ABC SDFSG XYZ.AFGAJK JKK"
Expectd Output : XYZ.AFGAJK

---------------------------------------------------------------------------------

$ echo "$InputVar" | cut -d ' ' -f 3
XYZ.AFGAJK

$ echo "$InputVar" | awk '/\./' RS=' '
XYZ.AFGAJK

$ echo "$InputVar" | awk '{for(i=1;i<=NF;i++) if(match($i,"\\.")) print $i}'
XYZ.AFGAJK

$ echo "$InputVar" | sed -n 's/.* \([^ .]*[.][^ .]*\) .*/\1/p'
XYZ.AFGAJK

---------------------------------------------------------------------------------


