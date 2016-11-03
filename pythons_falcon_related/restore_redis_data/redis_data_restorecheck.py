# -*- coding: utf-8 -*-
#!/usr/bin/python
import csv
from docopt import docopt
from rediscluster import StrictRedisCluster
from rediscluster.cluster_mgt import RedisClusterMgt
import redis
import traceback
import time
__doc__ = """Usage:
  example.py  --file=input_file.csv
"""
if __name__ == "__main__":
    try:
        args = docopt(__doc__, version='0.1.1rc')
        input_file = args['--file']
        csvfile = open(args['--file'], 'rb')
        fieldnames = ["addr", "save_dbsize"]
        reader = csv.DictReader(csvfile, fieldnames=fieldnames)  
        reader.next()
        connet_dict = {}
        for row in reader:
            addr = row["addr"]
            dbsize = row["save_dbsize"]
            cluster_host = addr.split(':')[0]
            cluster_port = addr.split(':')[1]
            connet_dict[addr] = (redis.StrictRedis(host = cluster_host, port= cluster_port, db=0), dbsize)
        while len(connet_dict):
            for addr, info in connet_dict.items():  
                redis_ins = info[0]
                if redis_ins.info()["loading"] == 1:
                    print "wait--- ", addr, " is restoreing"
                else:
                    dbsize = redis_ins.dbsize()
                    if dbsize == info[1]:
                        print "final ", addr, " is finish amd dbsize is right ", dbsize
                    else:
                        print "final ", addr, " is finish amd dbsize is wrong, save dbsize ", info[1], " now dbsize ", dbsize
                    del connet_dict[addr]
            if 0 == len(connet_dict):
                break
            time.sleep(10)
        print "all restore and check data finish!"    
        csvfile.close()
    except Exception, e:  
        print traceback.format_exc()
        print e