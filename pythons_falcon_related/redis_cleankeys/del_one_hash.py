# -*- coding: utf-8 -*-
#!/usr/bin/python

import csv
from docopt import docopt
import redis
import time
__doc__ = """Usage:
  example.py   --host=host --port=port --key=key --pipe_count=pipe_count --time_span=time_span
"""

if __name__ == "__main__":
    try:
        args = docopt(__doc__, version='0.1.1rc')
        rs = redis.StrictRedis(host= args['--host'], port= int(args['--port']), db=0)
        target_key = args['--key']
        pipe_count = int(args['--pipe_count'])
        time_span = int(args['--time_span'])
        del_index = 0
        field_count = rs.hlen(target_key)
        cursor = 0
        while field_count:
            cursor, field_list = rs.hscan(target_key, cursor=cursor, match=None, count=pipe_count)
            if len(field_list.keys()) :
                rs.hdel(target_key, *(field_list.keys()))
                time.sleep(time_span)
                print "del one time remain count ", field_count - len(field_list.keys())       
                field_list =[]
				field_count = field_count - len(field_list.keys())
            
        #if len(field_list) > 0:
        #    rs.hdel(user_key, field_list)
        #    field_list =[] 
        #    print "del last time"
        #print "del finish"
    except docopt as e:
        print e.message
        sys.exit()        
    
