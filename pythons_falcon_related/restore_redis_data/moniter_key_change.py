# -*- coding: utf-8 -*-
#!/usr/bin/python
import redis
import csv
import sys
import time
import signal
def signal_handler(signal, frame):
        print('You pressed Ctrl+C!')
        sys.exit(0)
signal.signal(signal.SIGINT, signal_handler)       
from docopt import docopt
__doc__ = """Usage:
  example.py  --file=file
"""
if __name__ == "__main__":
    try:
        monitor_key = "Ae0live"
        args = docopt(__doc__, version='0.1.1rc')
        rs = redis.StrictRedis(host='10.15.107.143', port=7430, db=0)
        rs.config_set("notify-keyspace-events", "AKE")
        with open(args['--file'], 'wb') as csvfile:
            fieldnames = ["command", "value", "time"]
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
            writer.writeheader()
            pub = rs.pubsub()
            pub.psubscribe( (str("*") + monitor_key + str("*")) )
            while True:
                message = pub.get_message()
                if message:
                    command = message["data"]
                    keys = rs.hkeys(monitor_key)
                    value = " ".join(keys)
                    str_time = time.strftime("%Y-%m-%d-%H-%M", time.localtime())
                    writer.writerow({"command": str(command), "value": value, "time": str_time})
                    print "write one time"
                time.sleep(0.001)
                    
    except Exception, e: 
        print e.message
        sys.exit()
    except KeyboardInterrupt:
        print "Bye"
        sys.exit()