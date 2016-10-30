#!/bin/sh

libPath="/home/tomcat/lpt10/online/fds-online/lib"
configPath="/data/app_resource/online/fds-online"
#websitePath="."
CLASSPATH=`find $libPath -name *.jar|xargs|sed "s/ /:/g"`
CLASSPATH="$configPath:.:$CLASSPATH"


export CLASSPATH

echo $CLASSPATH

pkill -9 -f jmxremote.port=6093


sleep 1
#rm -rf 2015*

nohup java -Xms4072m -Xmx4072m -XX:MaxPermSize=512m -Xss256k -Djava.rmi.server.hostname=1.1.1.150 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=6093 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false main.StartOnline > fds-online.out &


tailf fds-online.out



