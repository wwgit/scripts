#!/bin/bash
#char_replace.sh
#
#
#
#
#
#usage of sed "row_numberd":
#e.g sed "3d" -- it deletes the third row.
find ./ -name "$2" -print0 | xargs -0 sed -i "$1d" 


#usage of sed "row_number,$d":
#e.g. sed "3,$d" -- it deletes from 3rd row to the last row.
#find ./ -name "$2" -print0 | xargs -0 sed "$1,$d"       

