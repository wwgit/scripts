# -*- coding: utf-8 -*-
import time 
import sys
import traceback
import urllib2 
import json
import socket

from rediscluster.exceptions import RedisClusterException
from docopt import docopt
from rediscluster import StrictRedisCluster

__doc__="""Usage:
  example.py  --host=host --port=port --second=report_time --moni_url=moni_url --endpoint=endport
"""

def get_next_index(pool, cur_index):
	if len(pool) <= 1:
		return -1
	for k, v in pool.items():
		if k != cur_index:
			return k
	return -1

def copydict_bysrckeys(des_dict, src_dict):
	for k,v in src_dict.items():
		if des_dict.has_key(k):
			des_dict[k]=v
	return des_dict

def add_connect2pool(node_addr, pool, index):
		host=node_addr.split(':')[0]
		port=node_addr.split(':')[1]
		startup_nodes = [{"host": host, "port": port}]
		rc = StrictRedisCluster(startup_nodes=startup_nodes, max_connections=32, socket_timeout=0.1, decode_responses=False) 
		pool[index]=rc

def get_ip_address():
	s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
	s.connect(('baidu.com', 0))
	addr = s.getsockname()[0]
	s.close()
	return addr
  
def post_data(url, data):
	#send by http
	handler = urllib2.HTTPHandler()
	data = urllib.urlencode(data) 
	opener = urllib2.build_opener(handler)
	method = "POST"
	#request = urllib2.Request(url, data=json.dumps(data) )
	request.add_header("Content-Type",'application/json')
	request.get_method = lambda : method
	try:
		response = opener.open(request, data)
	except urllib2.HTTPError,e:
		 respoens = e
	if response.code == 200:
		print response.read()	
	else:
		print '{"err":1,"msg":"%s"}' % response

#ip:last_slowlog_info
global last_slow_log
def send_slowlog_info(url, slowlog_info, host_ip):
	metric = "redis"
	#endpoint = "host33"
	start_time_result = []
	spend_time_result = []
	step = 10
	#packge info
	for host, loglist in slowlog_info.items():
		host = host.replace("127.0.0.1", host_ip)
		for log in loglist:
			now = int(time.time())
			log_start_time = {
				'Metric': '%s.slow_log_1' % (metric,),
				'Endpoint': endpoint,
				'Timestamp': now,
				'Step': step,
				'Value': log["start_time"],
				'CounterType': "GAUGE",
				'TAGS': 'addr=%s'%host,
			}
			log_spend_time = {
				'Metric': '%s.slow_log_1' % (metric,),
				'Endpoint': endpoint,
				'Timestamp': now,
				'Step': step,
				'Value': log["duration"],
				'CounterType': "GAUGE",
				'TAGS': 'addr=%s' % (host),
			}
			#start_time_result.append(log_start_time)
			spend_time_result.append(log_spend_time)
			#exit()	
	#post_data(url, start_time_result)
	post_data(url, spend_time_result)
			
def send_rediscluster_info(url, redis_info, host_ip):
	metric = "redis"
	#endpoint = "host33"
	result = []
	step = 10
	timestamp = int(time.time())
	#packge info
	for host, nodes_info in redis_info.items():
		host = host.replace("127.0.0.1", host_ip)
		for metric_name, value in nodes_info.items():
			i = {
				'Metric': '%s.%s' % (metric, metric_name),
				'Endpoint': endpoint,
				'Timestamp': timestamp,
				'Step': step,
				'Value': value,
				'CounterType': "GAUGE",
				'TAGS': 'addr=%s' % (host),
			}
			result.append(i)
			#print "result", result
	#send by http
	post_data(url, result)

def pre_hande_nodeinfo(nodeinfo):
	if nodeinfo.has_key("used_memory"):
		nodeinfo["used_memory"] = nodeinfo["used_memory"]/1024

global endport 
if __name__ == "__main__":
	try:
		last_slowlog_info = {}
		args = docopt(__doc__, version='0.1.1rc')
		second = int(args["--second"])
		info_call_interval = second
		slowlog_call_interval = 1*second
		moni_url = args["--moni_url"]
		startup_nodes = [{"host": args["--host"], "port": args["--port"]}]
		endpoint = args["--endpoint"]
		rc = StrictRedisCluster(startup_nodes=startup_nodes, max_connections=32, socket_timeout=0.1, decode_responses=False) 
	except docopt as e:
		print e.message
		sys.exit()	
	except Exception, e:
		print "connect fail", e
		print traceback.format_exc()
		sys.exit()	

	#update config info time
	config_update_time = second * 10

	#call api time
	now = int(time.time())
	call_api_time ={"info" : 0, "slowlog" : 0}
	nodes_info={} 
	node_config={}
	config_loop_time = 10
	config_update_time = 0
	pool_need_update = True
	pool_connct={}
	cur_index=0
	host_ip = get_ip_address()
	while 1:
		try:
			now = int(time.time())
			cluster_info = {}	
			if now - call_api_time["info"] >= info_call_interval:
				call_api_time["info"] = now
				cluster_info = rc.info()

				#k:addr v:node_info update node info
				for k, node in cluster_info.items():
					node_info={"used_memory" : 0}	
					#copy cluster info
					nodes_info[k] = copydict_bysrckeys(node_info, node)
					if not node_config.has_key(k):
						config_update_time = 0
						node_config = rc.config_get("maxmemory")	
					
					if node_config[k]["maxmemory"] == '0':
						#no set maxmemory
						nodes_info[k]["mem_use_ratio"] = -1
					else:
						mem_ratio = 100*float(cluster_info[k]["used_memory"])/float(node_config[k]["maxmemory"])
						if mem_ratio > 80:
							nodes_info[k]["mem_use_ratio"] = mem_ratio
					#pre_hande_nodeinfo(nodes_info[k])
				#print "moni_url", moni_url
				#print "nodes_info", nodes_info
				send_rediscluster_info(moni_url, nodes_info, host_ip)

			if now - call_api_time["slowlog"] >= slowlog_call_interval:
				call_api_time["slowlog"] = now
				slowlog_info = rc.slowlog_get(1)
				new_slow_log = {}
				for k, log in slowlog_info.items():	
					if last_slowlog_info.has_key(k) and last_slowlog_info[k] != log[k][0]['id'] and log["duration"]:
						new_slow_log[k] = log

				send_slowlog_info(moni_url, new_slow_log, host_ip)

			#update pool info		
			if pool_need_update == True:
				pool_connct = {}
				index = 0
				for k, node in cluster_info.items():
					add_connect2pool(k, pool_connct, index)
					index = index + 1
				pool_need_update = False
				cur_index = 0
			#print "pool_connct", len(pool_connct)
			if len(pool_connct) > 0:
				cur_index = (cur_index+1)%len(pool_connct)
				#print "cur_index", cur_index
				rc = pool_connct[cur_index]
			#print "cur_rc", rc

			#update config k:addr v:node config info
			if (config_update_time + 1)% config_loop_time== 0:
				node_config = rc.config_get("maxmemory")	
			config_update_time = (config_loop_time + 1)%config_loop_time

			time.sleep(second)
		except RedisClusterException, e:
			#reconnct rc	 	
			#print traceback.format_exc()
			if 0 == len(pool_connct):
				print "no redis server can connect"
				sys.exit()	
			pool_connct.pop(cur_index)
			cur_index = get_next_index(pool_connct, cur_index)
			if cur_index < 0:
				print "pool_connet not host data"
				sys.exit()	
			pool_need_update = True
			rc = pool_connct[cur_index]
		except Exception, e:
			print traceback.format_exc()
			sys.exit()	
			
