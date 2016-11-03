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
from operator import itemgetter
from docopt import docopt
__doc__="""Usage:
  example.py --in_file=in --out_file=out --time_span=second
  """
a = 1
if __name__ == "__main__":
	try:
		args = docopt(__doc__, version='0.1.1rc')
		keymaker_info = {}
		with open("keymaker_map.csv", 'rb') as keymaker_csv:
			reader = csv.DictReader(keymaker_csv, dialect='excel')
			for row in reader:
				keymaker_info[row["TitleGroupCode"]] = row["Describe"]
					
		time_pattern = '%a %b %d %H:%M:%S %Y'
		in_file = open(args['--in_file'], 'rb')
		out_file = open(args['--out_file'], "w")
		out_csv_file = "out_res.csv"
		line = in_file.readline() 
		time_span = int(args['--time_span'])
		last_time_stamp = 0	
		index = 0
		line = in_file.readline()
		slow_keys_info = {}
		while line:
			#some filter
			if -1 == line.find('slow_log'):
				line = in_file.readline()
				continue
			time_end = line.find(']')
			if -1 == time_end:
				line = in_file.readline()
				continue
			str_stamp = line[1: time_end]
			time_stamp = int(time.mktime(time.strptime(str_stamp, time_pattern)))
			if time_stamp - last_time_stamp < time_span:
				line = in_file.readline()
				continue
			last_time_stamp = time_stamp
			out_file.write(line)
			
			#stat keys info
			key_st = int(line.find("key:"))
			key_end = int(line.find(";", key_st))
			slow_key = line[key_st +4:key_end]
			slow_key = slow_key.strip(' ')
			slow_key = slow_key[0:3]
			if slow_key == '':
				#get msg type
				key_st = int(line.find("msg_type"))
				key_end = int(line.find(";", key_st))
				slow_key = line[key_st+8:key_end]
				slow_key = "msgtyp_:" + slow_key.strip(' ')  
			if slow_key in slow_keys_info:
				slow_keys_info[slow_key] = slow_keys_info[slow_key] + 1
			else:
				slow_keys_info[slow_key] = 1
			index = index + 1
			if index % 100 == 0:
				print "has write ", index, "  line\n"
			line = in_file.readline()
		out_file.write("slow keys state result: \n")
		slow_keys_info = sorted(slow_keys_info.items(), key=itemgetter(1), reverse=True)
		with open(out_csv_file, 'wb') as res_csvfile:
			fieldnames = ["title_group", "time", "describe"]
			writer = csv.DictWriter(res_csvfile, fieldnames=fieldnames)
			writer.writeheader()			
			for one_key in slow_keys_info:
					if one_key[0][0:2] in keymaker_info:
						writer.writerow({"title_group": one_key[0], "time": str(one_key[1]), "describe": keymaker_info[one_key[0][0:2]]})
					else:
						writer.writerow({"title_group": one_key[0], "time": str(one_key[1]), "describe": "null"})
			
		in_file.close()
		out_file.close()
	except Exception, e: 
		in_file.close()
		out_file.close()        
		print e.message
		sys.exit()
	except KeyboardInterrupt:
		in_file.close()
		out_file.close()      
		print "Bye"
		sys.exit()
  
  
