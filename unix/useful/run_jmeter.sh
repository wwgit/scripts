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
    echo $line
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
cd /opt/apache-jmeter-2.12/bin
ips=
for line in $(cat ./iplist.txt)   #建议使用这种
do
    #echo line = $line
    ip="${line// /}"
     
     ips=$ips$ip,
     
done

ipss=`echo $ips|sed "s/,$//g"`
echo ipss = $ipss
#echo first $1
#echo second "$2"
#echo ips  ${ips##*,}
#/opt/apache-jmeter-2.12/bin/jmeter.sh -n -t $2 -r ${ips##*,} -l  result.jtl
nohup ./jmeter.sh -n -t ${1}.jmx -R $ipss -l $1_ret.jtl &

}

status()
{

for line in $(cat ./iplist.txt)   #建议使用这种
do
    echo $line
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
	start $2
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
