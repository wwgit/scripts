export CATALINA_HOME=.
#export JAVA_HOME="/home/tomcat/jdk1.7.0_67"
#export CLASS_PATH="$JAVA_HOME/lib:$JAVA_HOME/jre/lib"
#export PATH=".:$PATH:$JAVA_HOME/bin"


pkill -9 -f jmxremote.port=7094



sleep 1


#export JAVA_OPTS="-Xms4096m -Xmx4096m -XX:MaxPermSize=512m -Xss256k
#-Djava.rmi.server.hostname=192.168.220.150
#-Dcom.sun.management.jmxremote
#-Dcom.sun.management.jmxremote.port=1196
#-Dcom.sun.management.jmxremote.authenticate=false
#-Dcom.sun.management.jmxremote.ssl=false"


export JAVA_OPTS="-server -Xms4096m -Xmx4096m  -Xmn800M  
-XX:+UseConcMarkSweepGC
-XX:+UseParNewGC
-XX:SurvivorRatio=8
-XX:CMSInitiatingOccupancyFraction=70
-XX:+UseCMSCompactAtFullCollection
-XX:+DisableExplicitGC
-XX:+CMSClassUnloadingEnabled
-XX:+CMSParallelRemarkEnabled
-XX:PermSize=1024m -XX:MaxPermSize=1024m
-Djava.awt.headless=true
-Dcom.sun.management.jmxremote.ssl=false
-Dcom.sun.management.jmxremote.port=7094
-Dcom.sun.management.jmxremote.authenticate=false
-Djava.rmi.server.hostname=192.168.220.150"


./bin/startup.sh


tailf ./logs/catalina.out



