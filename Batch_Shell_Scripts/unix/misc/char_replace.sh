#!/bin/bash
#char_replace.sh
#
#
#
#

# useage of sed:
#find file with NULL character added to each end of file name founded
#Then, pass string contained file names to xargs and xargs handles
#this string which means it will convert string to a
#list. '-0' option tells xargs to cut string using NULL as separator.
#xargs sends it to sed and sed executes string replacement command.
#This method is used to edit more than one files one time.
#It sees the old string as a word to be replaced.
#: 
find ./ -name "$3" -print0 | xargs -0 sed -i "s/\<$1\>/$2/g" 



#usage of variable:
#find file with NULL character added to each end of file name founded.
#Then, pass string contained file names to xargs. xargs handles string as
#above one.
#xargs sends its result to cat and cat sends result to str variable.
#Finally we do string replacement within the str variable and print result to
#the screen. 
#Note: This method is more efficient than the above method but it won't
#change the contents of the given file/files.
#:
#str=`find ./ -name "$3" -print0 | xargs -0 cat`      
#echo ${str//$2/$1}

