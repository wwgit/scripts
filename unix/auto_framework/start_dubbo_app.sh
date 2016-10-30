#!/bin/bash

echo 'starting tomcat-ftx-online-search ...'
cd /home/tomcat/lpt1/tomcat-ftx-online-search/
./run.sh
echo 'starting tomcat-ftx-online-search done'

echo 'starting tomcat-ftx-online ...'
cd 
/home/tomcat/lpt1/tomcat-ftx-online/run.sh
echo 'starting tomcat-ftx-online done'

echo 'starting tomcat-pdc-online ...'
/home/tomcat/lpt1/tomcat-pdc-online/run.sh
echo 'starting tomcat-pdc-online done'

echo 'starting tomcat-acc-online ...'
/home/tomcat/lpt1/tomcat-acc-online/run.sh
echo 'starting tomcat-acc-online done'