#!/bin/bash

today=`date +"%Y%m%d"`
#sourceFile=$3_${today}.txt

echo today is $today

keywords=`echo $3|awk -F "," 'END{for(i=1;i<=NF;i++) {print $i}}'`

#redis-cli -h $1 -p $2 keys *${keys}* > ${sourceFile}

lineBuffers=()
i=0
suffix=[1-9][0-9]
for keyword in ${keywords[@]}
#echo ${keyword[$i]}
do
    echo keyword is ${keyword}
	dataArr=`redis-cli -h $1 -p $2 keys *${keyword}${suffix}*`
	#sed -i 's/.*'$keyword'.*/'$keyword'/g' > tmp.txt
	j=0
	for element in ${dataArr[@]}
	do
	#echo element is ${element}
	tmp=`echo ${element}|sed -n 's/.*\('${keyword}${suffix}'\).*/\1/p'`
		if [ ! ${lineBuffers[$j]} ]; then
			lineBuffers[$j]=$tmp
		else
			if test -n $tmp; then
				lineBuffers[$j]=${lineBuffers[$j]},$tmp				
			fi			
		fi
		echo $j ${lineBuffers[$j]} 
		((j++))
	done
        let i++	
done

for line in ${lineBuffers[@]}
do
	echo $line >> data_$today.csv
done

