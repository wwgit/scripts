# -*- coding: utf-8 -*-
#!/usr/bin/python

import csv
from docopt import docopt
__doc__ = """Usage:
  example.py  --input=input_file --tilegroup=tile_file
"""
if __name__ == "__main__":
    try:
        args = docopt(__doc__, version='0.1.1rc')
        tile_group = {}
        with open(args['--tile_file'], 'rb') as csvfile:
            reader = csv.DictReader(csvfile, dialect='excel')
            for row in reader:
                try:
                    tile_group[row["TitleGroupCode"]] = row["Describe"]
                except Exception, e:  
                    print e
                    
        with open(args['--input_file'], 'rb') as csvfile:
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
                        res_data[pre_key] = {"key_count" : 1, "mem_sz": size_in_bytes}
                except Exception, e:  
                    print e
    except docopt as e:
        print e.message
        sys.exit()