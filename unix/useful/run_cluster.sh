#!/bin/bash

redis-server /opt/app/redis_cluster/7000/redis-7000.config > /opt/app/redis_cluster/logs/redis-7000.log 2>&1 &  
redis-server /opt/app/redis_cluster/7001/redis-7001.config > /opt/app/redis_cluster/logs/redis-7001.log 2>&1 & 
redis-server /opt/app/redis_cluster/7002/redis-7002.config > /opt/app/redis_cluster/logs/redis-7002.log 2>&1 &  
redis-server /opt/app/redis_cluster/7003/redis-7003.config > /opt/app/redis_cluster/logs/redis-7003.log 2>&1 &  
redis-server /opt/app/redis_cluster/7004/redis-7004.config > /opt/app/redis_cluster/logs/redis-7004.log 2>&1 &   
redis-server /opt/app/redis_cluster/7005/redis-7005.config > /opt/app/redis_cluster/logs/redis-7005.log 2>&1 &
