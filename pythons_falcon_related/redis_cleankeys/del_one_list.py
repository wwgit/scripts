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
        field_count = rs.llen(target_key)
        cursor = 0
        pipe = rs.pipeline(transaction=False)
        while field_count - del_index:
            pipe.lpop(target_key)
            del_index = del_index + 1
            if del_index and del_index % pipe_count == 0 :
                pipe.execute()
                print "del one time remain list count: ", field_count - del_index     
                time.sleep(time_span) 
                pipe = rs.pipeline(transaction=False)
        print "del finish"
    except docopt as e:
        print e.message
        sys.exit()        
    