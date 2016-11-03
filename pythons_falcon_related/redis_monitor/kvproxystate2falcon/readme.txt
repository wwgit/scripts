          post_kvproxy_info.py 脚本说明：
1:用途
  把redis集群的信息：慢日志和内存使用比例等上传到小米监控系统

2:运行命令
python post_kvproxy_info.py  --host 10.15.144.25 --port 6410 --moni_url http://10.15.144.33:1988/v1/push --second 1 --endpoint host33
host : redis 地址
port : redis 端口
moni_url : 小米监控系统地址
endpoint : 小米监控系统主机地址
second : 信息采集频率


          post_kvproxy_stat.py 脚本说明：
1:用途
  把kvproxy运行的状态上传到小米监控系统

2:运行命令
python post_kvproxy_stat.py --kv_host="10.15.144.25" --kv_port=22222  --moni_url=http://10.15.144.25:1988/v1/push --end_point=host25 --second=1 --server2addr=server2addr.csv
kv_host : kvproxy 地址
kv_port : kvproxy 端口
moni_url : 小米监控系统地址
endpoint : 小米监控系统主机地址
second : 信息采集频率
server2addr:redis后端地址映射，内容举例如下：
"server","addr"
"10.15.144.102:6400",server1

//上面配置信息在kvproxy配置里面能查询到
