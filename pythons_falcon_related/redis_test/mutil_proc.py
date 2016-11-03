# -*- coding: utf-8 -*-
#!/usr/bin/python
import redis
import multiprocessing
import time
import signal
import os
def worker():
        print "________run in worker________"
        rs = redis.StrictRedis(host='10.15.107.143', port=10012, db=0)
        pipe = rs.pipeline(transaction=False)
        now = int(time.time())
        while(1):
                for i in range(0, 20000):
                    pipe.set(str(now) + str('_') + str(i), 'bar'+ str(now))   
                    pipe.expire(str(now) + str('_') + str(i), 5)
                res = pipe.execute()
                os.getpid()
                print "all finish one time  ", os.getpid()

pidlist = []
def exithanddle():
        for pid in pidlist:
                pid.terminate()
    
if __name__ == "__main__":
        signal.signal(signal.SIGINT,exithanddle) #当按下Ctrl + C 终止进程
        for i in range(0, 4):
                p = multiprocessing.Process(target = worker, )
                pidlist.append(p)
                p.start()
        print "run in here"
        for pid in pidlist:
                pid.join()
        