# -*- coding: utf-8 -*-
#用于统计redis数据在内存中的分布，流程:dump.rdb 通过redis-rdb-tools统计出all.csv-->final.csv
#!/usr/bin/python

import csv
from docopt import docopt
__doc__ = """Usage:
  example.py  --file=file --res=res_file
"""
if __name__ == "__main__":
    try:
        last_slowlog_info = {}
        args = docopt(__doc__, version='0.1.1rc')
        res_data = {}
        with open(args['--file'], 'rb') as csvfile:
            reader = csv.DictReader(csvfile, dialect='excel')
            index = 0
            for row in reader:
                try:
                    index = index + 1
                    if index % 10000 == 0:
                        print "index: ", index
                    pre_key = row["key"][0:2]
                    size_in_bytes = int(row["size_in_bytes"])
                    if res_data.has_key(pre_key):
                        res_data[pre_key]["key_count"] = res_data[pre_key]["key_count"] + 1
                        res_data[pre_key]["mem_sz"] = res_data[pre_key]["mem_sz"] + size_in_bytes
                    else:
                        res_data[pre_key] = {"key_count":1, "mem_sz": size_in_bytes}
                except Exception, e:  
                    print e
                    
        with open(args["--res"], "wb") as csvfile:
            fieldnames = ["pre_key", "mem_sz", "key_count"]
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
            writer.writeheader()
            for k,v in res_data.iteritems():
                writer.writerow({"pre_key": str(k), "mem_sz": v["mem_sz"], "key_count": v["key_count"]})
    except docopt as e:
        print e.message
        sys.exit()
