# -*- coding: utf-8 -*-
#!/usr/bin/python
import telnetlib
#import psutil
import sys
import time
import traceback
import urllib2
import json
import csv
import socket
from docopt import docopt

#python post_kvproxy_stat.py --kv_host=10.15.107.189 --kv_port=10012 --moni_url=http://10.15.88.68:1234/v1/push --end_point=end_port  
#--second=5 --server2addr=Server2addr.csv
__doc__="""Usage:
  example.py --kv_host=host --kv_port=port --moni_url=moni_url --end_point=end_port  
  --second=report_time --server2addr=map.csv
  """

def post_data(url, data):
	#send by http
	handler = urllib2.HTTPHandler()
	opener = urllib2.build_opener(handler)
	method = "POST"
	request = urllib2.Request(url, data=json.dumps(data) )
	request.add_header("Content-Type",'application/json')
	request.get_method = lambda : method
	try:
		response = opener.open(request)
		if response.code == 200:
			#print response.read()	
			pass
		else:
			print '{"err":1,"msg":"%s"}' % response
	except urllib2.HTTPError,e:
		respoens = e

	
if __name__ == "__main__":
	try:
		args = docopt(__doc__, version='0.1.1rc')
		sleep_second = args['--second']
		end_point = args['--end_point']
		moni_url = args['--moni_url']
		kv_host = args['--kv_host']
		kv_port = args['--kv_port']
		kv_addr = kv_host
		#init server2addr
		server2addr = {}
		with open(args['--server2addr'], 'rb') as csvfile:
			reader = csv.DictReader(csvfile, dialect='excel')
			#init server2addr
			server2addr = {}
			with open(args['--server2addr'], 'rb') as csvfile:
				reader = csv.DictReader(csvfile, dialect='excel')
				for row in reader:
					try:
							server = row["server"]
							addr = row["addr"]
							server2addr[addr] = server
					except Exception, e: 
							print e	
			
		file_list = ["responses", "response_bytes", "requests", "request_bytes"]		
		#init old_data
		old_data = {}
		for server_name in server2addr.keys():
			for field in file_list:
				old_data[server_name + field] = 0
				print server_name + field + '  =  ' + str(old_data[server_name + field])
				
		while 1 :
			tn = telnetlib.Telnet(str(kv_host), int(kv_port))
			print tn
			now = time.time()
			kv_state_info = json.loads(tn.read_all())
			print 'kv stat info: ' + kv_state_info
			kv_servers_info = kv_state_info["alpha"]
			print 'kv servers info: ' + kv_servers_info
			send_data = []
			for server_name in kv_servers_info.keys():
				if not server2addr.has_key(server_name):
					continue
				for field in file_list:
					
					server_info = {
						'Metric': str('kvproxy_') +  kv_addr + str('_') + field,
						'Endpoint': end_point,
						'Timestamp': int(now),
						'Step': 30,
						'Value': int(kv_servers_info[server_name][field] - old_data[server_name + field]),
						'CounterType': "GAUGE",
						'TAGS': "redis=" + server2addr[server_name]
						}	
					send_data.append(server_info)
					old_data[server_name + field] = int(kv_servers_info[server_name][field])
			#send data		
			post_data(moni_url, send_data)
			#print "one time"			
			time.sleep(float(sleep_second))
			
	except Exception, e:  
		print traceback.format_exc()	
		print e	
