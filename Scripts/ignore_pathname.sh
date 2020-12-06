# Reference : Stackoverflow : https://unix.stackexchange.com/questions/76466/find-command-how-to-ignore-pathname

find -type f -name "*.c" -exec basename {} \;

