# -*- coding: utf-8 -*-
#!/usr/bin/python
import csv
from docopt import docopt
from rediscluster import StrictRedisCluster
from rediscluster.cluster_mgt import RedisClusterMgt
import redis
import traceback
import socket
__doc__ = """Usage:
  example.py  --host=host --port=port --res=res_file
"""
#def get_ip_address():
	#s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
	#s.connect(('baidu.com', 0))
	#addr = s.getsockname()[0]
	#s.close()
	#return addr
if __name__ == "__main__":
    try:
        args = docopt(__doc__, version='0.1.1rc')
        host = args['--host']
        port = args['--port']
        startup_nodes = [{"host": host, "port": port}]
        rmg = RedisClusterMgt(startup_nodes)
        csvfile = open(args['--res'], 'wb')
        fieldnames = ["addr", "save_dbsize"]
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames) 
        writer.writeheader()
        for addr, v in rmg.slots()["master"].items():
            cluster_host = addr.split(':')[0]
	    if cluster_host == '127.0.0.1':
		cluster_host = host
            cluster_port = addr.split(':')[1]
            r = redis.StrictRedis(host = cluster_host, port= cluster_port, db=0)
            dbsize = r.dbsize()
            writer.writerow({"addr": cluster_host+str(':')+cluster_port, "save_dbsize":str(dbsize)})   
            r.bgsave()
        csvfile.close()
    except Exception, e:  
        print traceback.format_exc()
        print e