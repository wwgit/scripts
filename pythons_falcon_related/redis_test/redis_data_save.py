# -*- coding: utf-8 -*-
#!/usr/bin/python
import csv
from docopt import docopt
from rediscluster import StrictRedisCluster
import redis
__doc__ = """Usage:
  example.py  --host=host --port=port --res=res_file
"""
if __name__ == "__main__":
    try:
        args = docopt(__doc__, version='0.1.1rc')
        host = args['--host']
        port = args['--port']
        startup_nodes = [{"host": host, "port": port}]
        rc = StrictRedisCluster(startup_nodes=startup_nodes, decode_responses=True)
        csvfile = open(args['--res'], 'wb')
        fieldnames = ["addr", "dbsize"]
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames) 
        for cluster in rc.cluster_nodes():
            if cluster["flags"](0) == u'master':
                cluster_host = cluster['host']
                cluster_port = cluster['port']
                r = redis.StrictRedis(host=cluster_host, port= cluster_port, db=0)
                dbsize = r.dbsize()
                writer.writerow({"addr": cluster_host+str(':')+cluster_port, "dbsize":str(dbsize)})
                r.bgsave()
        csvfile.close()
    except Exception, e:  
        print e    
