# -*- coding: utf-8 -*-
#!/usr/bin/python
import psutil
import sys
import time
import traceback
import urllib2
import json
import socket
from docopt import docopt

__doc__="""Usage:
  example.py --p_name=p_name --moni_url=moni_url --end_point=end_port  --second=report_time 
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

def get_procebyname(name):
	for proc in psutil.process_iter():
		try:
			target_pinfo = proc.as_dict(attrs=['pid', 'name'])
		except psutil.NoSuchProcess:
			pass
		else:
			if target_pinfo["name"] == p_name:
				return proc 

	print "no found ", p_name
	return None
	
if __name__ == "__main__":
	try:
		args = docopt(__doc__, version='0.1.1rc')
		p_name = args['--p_name']
		sleep_second = args['--second']
		end_point = args['--end_point']
		moni_url = args['--moni_url']
		while 1 :
			now = time.time()
			target_process = get_procebyname(p_name)
			if target_process == None:
				sys.exit(0)
			mem_info = {
				'Metric': 'kvproxy_meminfo',
				'Endpoint': end_point,
				'Timestamp': int(now),
				'Step': 30,
				'Value': int(target_process.memory_info().rss),
				'CounterType': "GAUGE",
				'TAGS': '',
				}
			send_data = []
			send_data.append(mem_info)
			post_data(moni_url, send_data)
			#print "post one time"
			time.sleep(float(sleep_second))
			#time.sleep(1)
			
	except Exception, e:  
		print traceback.format_exc()	
		print e	
