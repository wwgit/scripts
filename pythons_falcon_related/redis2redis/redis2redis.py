#!/usr/bin/python 
import redis
import traceback 
import yaml
from multiprocessing import Process
from multiprocessing import Queue
import os
import time
from argparse import ArgumentParser
import signal
import types
import sys
import copy  
import pickle
import crc16

#global 
command_queue = Queue()
fetch_data_queue = Queue()
fetch_endflag__queue = Queue()
end_queue = Queue()
static_queue = Queue()
debug_queue = Queue()

class fetch_data:
	def __init__(self):
		self.key = ""
		self.type_ = ""

class redis_command_data:
	def __init__(self):
		self.key = ""
		self.type_ = ""
		self.value = ""

def sig_handler(sig, frame):
	try:
		#print "_____teminate process______"
		#terminate()
		print "sig_handler  ", os.getpid()
		end_queue.put(None)
		exit(0)
	except Exception, e:
		exit(0)

#process send data to des redis
def pipe_send2redis(config):
	try:
	#	return
		#sig+str(os.getpid())nal.signal(signal.SIGTERM, sig_handler)
		#signal.signal(signal.SIGINT, sig_handler)
		send_pipe_count = int(config["send_pipe_count"])
		des_host = config["des_host"]
		des_port = config["des_port"]

		#print "pipe_send2redis pid:", os.getpid()
		des_r = redis.StrictRedis(host=des_host, port=des_port, db=0)
		#sync with des
		rs = des_r.ping()

		#f=file("hello.txt"+str(os.getpid()),"a+")
		pip = des_r.pipeline(transaction=False)
		number = send_pipe_count	
		total_count = 0
		while 1:
			while number:
				item = command_queue.get()
				number = number - 1
				if None == item:
					#finish last time send
					command_count = len(pip.command_stack)	
					try:
						res =pip.execute()
					except Exception, e:
						print e, "  ", pip.command_stack
						print "75 _______________________________________", os.getpid(), "  ", command_count
					print os.getpid()," process total send ", total_count, "  "
					#print os.getpid()," pipe_send2redis total send ", total_count, "  ", " len(res) ", len(res), " len(pip) ", command_count
					#total_count = static_queue.get()
					print "all has total send ", total_count + send_pipe_count - number
					#static_queue.put(total_count + send_pipe_count - number)
					print "end_queue.put(None) 77 "
					end_queue.put(None)
					return
				else:
					total_count = total_count + 1
					if item.type_ == 'string':
						pip.set(item.key, item.value)
					elif item.type_ == 'list':
						pip.rpush(item.key, *item.value)
					elif item.type_ == 'hash':
						# type(item.value)
						if type(item.value) is types.StringType:
							pip.hset(item.key, item.value)
						elif type(item.value) is types.DictType:
							pip.hmset(item.key, item.value)
						else:
							print "type error ", item.value
					elif item.type_ == 'set':
						pip.sadd(item.key, item.value)
					elif item.type_ == 'zset':
						append_data = []	
						for pair in item.value:
							append_data.append(pair[1])
							append_data.append(pair[0])
						pip.zadd(item.key, *append_data)
					else:
						print "type error", item.types
			#out while
			command_count = len(pip.command_stack)	

			#d = copy.deepcopy(pip.command_stack)
			try:
				print "before send one time ", send_pipe_count 
				res = pip.execute()
			except Exception , e:
				print e, "  ", pip.command_stack
				info=sys.exc_info()
				print info[0], ":", info[1]
				print traceback.format_exc(), os.getpid(), "  ", res
				#end_queue.put(None)
				#pickle.dump(d, f)
				#return

			#total_count = static_queue.get()
			print "has send total ", total_count + send_pipe_count 
			#static_queue.put(total_count + send_pipe_count)
			number = send_pipe_count	
			#reseend one time/
			pip = des_r.pipeline(transaction=False)
	except:
		print "end_queue.put(None)  127"
		end_queue.put(None)
		traceback.print_exc()

#process pipline get data
def pipe_getdatas(config):
	try:
		#return
		print "pipe_getdatas pid:", os.getpid()
		#signal.signal(signal.SIGTERM, sig_handler)
		#signal.signal(signal.SIGINT, sig_handler)
		get_pipe_count = int(config["get_pipe_count"])
		src_host = config["src_host"]
		src_port = config["src_port"]
		src_r = redis.StrictRedis(host=src_host, port=src_port, db=0)

		pipe_types = []
		pipe_keys = []
		pipe_get_values = src_r.pipeline(transaction=False)
		fetch_process_count = int(v["fetch_process_count"])
		while 1:
			fetch_data_item = fetch_data_queue.get()
			if None == fetch_data_item:
				send_process_count = int(config["send_process_count"]) 
				#put remain data queue		
				if len(pipe_keys) and len(pipe_types) :
					pipe_values = pipe_get_values.execute()
					print "____after get redis_data count: ", len(pipe_values)
					for i in range(0, len(pipe_keys)):
						item = redis_command_data()
						item.key = pipe_keys[i]	
						item.type_ = pipe_types[i]	
						item.value = pipe_values[i]	
						if debug_queue.qsize() > 0 :
							print "159 error ", os.getpid()

						command_queue.put(item)
				fetch_endflag__queue.put(None)
				while fetch_endflag__queue.qsize() < fetch_process_count:
					time.sleep(1)
				try:
					end = fetch_data_queue.get_nowait()
					if end == '$':
						print "notification end"
						for i in range(0, send_process_count):
							command_queue.put(None)
						debug_queue.put(None)
				except Exception, e:
					print "170 ", e, os.getpid()
					pass

				print "pipe_getdatas finish", os.getpid()
				print "end_queue.put(None) 181", os.getpid()
				end_queue.put(None)
				#exit(0)
				return 

			pipe_keys.append(fetch_data_item.key)
			pipe_types.append(fetch_data_item.type_)
			if fetch_data_item.type_ == 'string':
				pipe_get_values.get(fetch_data_item.key)
			elif fetch_data_item.type_ == 'list':
				pipe_get_values.lrange(fetch_data_item.key, 0, -1)
			elif fetch_data_item.type_ == 'hash':
				pipe_get_values.hgetall(fetch_data_item.key)
			elif fetch_data_item.type_ == 'set':
				pipe_get_values.smembers(fetch_data_item.key)
			elif fetch_data_item.type_ == 'zset':
				pipe_get_values.zrange(fetch_data_item.key, 0, -1, withscores=True)
			else:
				print "type error", fetch_data_item.key
				pipe_keys.remove(fetch_data_item.key)
			if len(pipe_keys) % get_pipe_count == 0:
				pipe_values = pipe_get_values.execute()
				print "after get redis_data count: ", len(pipe_types)
				if len(pipe_values) != len(pipe_types) or len(pipe_values) != len(pipe_keys) :
					print "data error"
				#put to queue		
				for i in range(0, len(pipe_keys)):
					item = redis_command_data()
					item.key = pipe_keys[i]	
					item.type_ = pipe_types[i]	
					item.value = pipe_values[i]	
					if debug_queue.qsize() > 0 :
						print "209 error ", os.getpid()
					command_queue.put(item)
				#wait queue consume	
				enough_size = 5000
				while command_queue.qsize() > enough_size:
					time.sleep(1)	
				#get again
				pipe_types = []
				pipe_keys = []
				pipe_get_values = src_r.pipeline(transaction=False)

	except:
		end_queue.put(None)
		traceback.format_exc()

#filter key ok:true 
def filter_key(k, st_slot, ed_slot):
	slot = int(crc16.crc16xmodem(k))
	if slot <= ed_slot and slot >= st_slot:
		return True
	return False

def prepare_get_data(config):
	try:
		#print "prepare_get_data pid:______", os.getpid()
		#return
		#signal.signal(signal.SIGTERM, sig_handler)
		#signal.signal(signal.SIGINT, sig_handler)

		get_pipe_count = int(config["get_pipe_count"])
		src_host = config["src_host"]
		src_port = config["src_port"]
		st_slot = config["st_slot"]
		ed_slot = config["ed_slot"]

		src_r = redis.StrictRedis(host=src_host, port=src_port, db=0)

		#get keys and types
		keys = src_r.keys('*')
		print "get keys count ", len(keys)
		pip_get_type = src_r.pipeline(transaction=False)
		index = 0
		for k in keys:
			if False ==  filter_key(k,st_slot, ed_slot):
				keys.remove(k)
				continue
			pip_get_type.type(k)
		types = pip_get_type.execute()
		if len(types) != len(keys):
			print "data error", "len(k)", len(keys), "len(type)", len(types)
			return
		#put to fetch_data_queue
		for index in range(0, len(keys)):
			item = fetch_data()
			item.key = keys[index]	
			item.type_ = types[index]	
			fetch_data_queue.put(item) 

		fetch_process_count = int(config["fetch_process_count"]) 
		for i in range(0, fetch_process_count):
			#notification end
			print "fetch_data_queue none ", i
			fetch_data_queue.put(None)

		fetch_data_queue.put('$') 
		#print "prepare_get_data finish ", os.getpid(), "len ", fetch_data_queue.qsize()
		#end_queue.put(None)
		return
	except:
		traceback.print_exc()

if __name__ == "__main__":
	try:
		signal.signal(signal.SIGTERM, sig_handler)
		signal.signal(signal.SIGINT, sig_handler)
		#signal.signal(signal.SIGCHLD, signal.SIG_IGN)
		st = time.time() 
		print "program st", st, os.getpid()
		p = ArgumentParser(usage='this usage tip', description='tracation redis data to redis') 
		p.add_argument('--config_path', default='config.yml', help='config file path')  
		args = p.parse_args()  
		if not os.path.exists(args.config_path):
			print "config path error", args.config_path
			exit(-1)
		f_config = open(args.config_path)
		data_config = yaml.load(f_config)
		proc_list = []
		w_st = time.time()

		#get src key and types
		for k,v in data_config.items():
			prepare_get_data(v)
#			proc = Process(target = prepare_get_data, args=(v, ))
#			proc.daemon = True
#			proc.start()
#			proc_list.append(proc)
#
			fetch_process_count = int(v["fetch_process_count"])
			for i in range(0, fetch_process_count):
				proc = Process(target = pipe_getdatas, args=(v, ))
				proc.daemon = True
				proc.start()
				proc_list.append(proc)

			send_process_count = int(v["send_process_count"])
			for i in range(0, send_process_count):
				proc = Process(target = pipe_send2redis, args=(v, ))
				proc.daemon = True
				proc.start()
				proc_list.append(proc)

		#wait all end
		total_count = 0
		while end_queue.qsize() < fetch_process_count + send_process_count:
			#total_count = static_queue.get()
			#print "has send items", total_count
			time.sleep(1)
		print "command_q ", command_queue.qsize()
		if command_queue.qsize():
			print "one remain items ", command_queue.get()
		print "fetchdata_q ", fetch_data_queue.qsize()
		command_queue.close()
		fetch_data_queue.close()
		f_config.close()
		ed = time.time()
		print "work time %f s"%(ed - w_st)
		print "spend all time %f s"%(ed - st)
		#exit(0)
	except:
		traceback.print_exc()

