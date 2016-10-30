#/bin/bash
app="jmeter"
#ip="10.15.107.203"

#test get pid
#cmd="ps -aef | grep $app |grep -v grep | awk '{print \$2}'"
#ret=`ssh -n -q root@$ip "$cmd"`

usage="$0 start|stop"

stop()
{

for line in $(cat ./iplist.txt)   #建议使用这种
do
    #echo $line
	ip="${line// /}"
	cmd="ps -aef | grep $app |grep -v grep | awk '{print \$2}' | xargs kill -9"
	ret=`ssh -n -q root@$ip "$cmd" `
	#echo $? 
	if [ "$?" == "0" ] ; then
		echo "ok!已停止$ip上的jmeter-server！"
	else
		echo "Oops!不能停止$ip上的jmeter-server！"
	fi

done
}

start()
{

for line in $(cat ./iplist.txt)   #建议使用这种
do
    #echo $line
        ip="${line// /}"
        cmd="cd /opt/apache-jmeter-2.12/bin; >agent.log; nohup ./jmeter-server -Djava.rmi.server.hostname=$ip > agent.log 2>&1 & "
        ret=`ssh -n -q root@$ip "$cmd" `
        #echo $? 
        if [ "$?" == "0" ] ; then
                echo "ok!已启动$ip上的jmeter-server！"
        else
                echo "Oops!不能启动$ip上的jmeter-server！"
        fi

done
}

status()
{

for line in $(cat ./iplist.txt)   #建议使用这种
do
    #echo $line
        ip="${line// /}"
        cmd="ps -aef | grep $app |grep -v grep | awk '{print \$2}'"
        ret=`ssh -n -q root@$ip "$cmd" `
	#echo $ret
        if [ "$ret"x != "x" ] ; then
                echo "ok! $ip上的jmeter-server还在运行！"
        else
                echo "Oops!$ip上的jmeter-server挂了！"
        fi

done

}

usage="$0 start|stop|status"
case $1 in
start)
	start
	;;
stop)
	stop
	;;
status)
	status
	;;
*)
	echo -e ${usage}
esac
