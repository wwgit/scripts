#/bin/bash
app="jmeter"
#ip="10.15.107.203"

#test get pid
#cmd="ps -aef | grep $app |grep -v grep | awk '{print \$2}'"
#ret=`ssh -n -q root@$ip "$cmd"`

usage="$0 start|stop"

stop2()
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

start2()
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

status2()
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

start()
{
cd /opt/apache-jmeter-2.12/bin
>test.log
>client.jtl
#nohup ./jmeter -n -t ./client.jmx -R 10.15.107.181,10.15.107.203,10.15.107.176,10.15.144.224,10.15.144.76,10.15.107.171,10.15.107.164,10.15.144.70,10.15.107.175 -l client.jtl > test.log 2>&1 &

nohup ./jmeter -n -t ./dxspirit.jmx -R 10.15.107.176,10.15.144.224,10.15.144.76,10.15.107.171,10.15.107.164,10.15.144.70,10.15.107.175,10.15.107.159,10.15.107.241,10.15.107.110,10.15.107.116,10.15.107.117,10.15.144.77,10.15.144.85,10.15.144.86,10.15.144.169,10.15.144.170,10.15.144.171,10.15.144.172,10.15.144.173  -l client.jtl > test.log 2>&1 &
echo "test started..."
}

stop()
{
ps -aef | grep jmeter |grep -v grep | awk '{print $2}' | xargs kill -9
echo "test stoped."
}

status()
{
 echo "status"
}


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


