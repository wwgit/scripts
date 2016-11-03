# -*- coding: utf-8 -*-
import time 
import sys
import traceback
import urllib2 
import json
import socket
import csv
import datetime
from rediscluster.exceptions import RedisClusterException
from docopt import docopt
from rediscluster import StrictRedisCluster

__doc__="""Usage:
  example.py  --host=host --port=port --slow_count=count --bef_day=day
"""

if __name__ == "__main__":
	try:
		last_slowlog_info = {}
		args = docopt(__doc__, version='0.1.1rc')
		startup_nodes = [{"host": args["--host"], "port": args["--port"]}]
		time_stamp = time.strftime("%Y-%m-%d_%H:%M", time.localtime())
		slow_count = int(args["--slow_count"])
		bef_second = 3600 * 24 * int(args["--bef_day"])
		now_time = time.time()
		rc = StrictRedisCluster(startup_nodes=startup_nodes, max_connections=32, socket_timeout=0.1, decode_responses=False) 
		#slow log
		with open(time_stamp+"_slowlog.csv", 'w') as slow_log_csv:
			fieldnames = ['ip', 'start_time', 'duration', 'command', 'log_id']
			writer = csv.DictWriter(slow_log_csv, fieldnames=fieldnames)
			writer.writeheader()
			for ip, slow_logs in rc.slowlog_get(slow_count).iteritems():
				for slow_log in slow_logs:
					#filter by time
					if now_time - int(slow_log['start_time']) > bef_second:
						print "____________"
						continue
					#stand time zoom
					#start_time = datetime.datetime.utcfromtimestamp(int(slow_log['start_time'])).strftime("%Y-%m-%d %H:%M:%S") 
					#local time zoom
					start_time = datetime.datetime.fromtimestamp(int(slow_log['start_time'])).strftime("%Y-%m-%d %H:%M:%S") 
					writer.writerow({'ip':ip, 'start_time':start_time, 'duration':slow_log['duration'], 'command':slow_log['command'], 'log_id':slow_log['id']})
		with open(time_stamp+"_redisinfo.csv", 'w') as redis_info_csv:	
			fieldnames = ['ip', 'used_memory', 'config_max_mem', "mem_ratio"]
			writer = csv.DictWriter(redis_info_csv, fieldnames=fieldnames)
			writer.writeheader()
			config_max_mems = rc.config_get("maxmemory")
			for ip, info in rc.info().iteritems():
				config_max_mem = -1
				if config_max_mems.has_key(ip):
					config_max_mem = config_max_mems[ip]
				writer.writerow({'ip':ip, 'used_memory':info['used_memory'], 'config_max_mem':config_max_mem['maxmemory'], 'mem_ratio':float(info['used_memory'])/float(config_max_mem['maxmemory'])})
				
	except docopt as e:
		print e.message
		sys.exit()	
	except Exception, e:
		print "connect fail", e
		print traceback.format_exc()
		sys.exit()	
