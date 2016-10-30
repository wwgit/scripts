#!/bin/bash



if [ $# -ne 1 ]; then

echo -e "need parameter"


exit 0;

fi;

ps -e | grep $1 | cut -c1-10 |xargs kill -9




