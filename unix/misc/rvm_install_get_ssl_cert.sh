#!/bin/bash

ret_log='result.log'


err_quit(){

  test ""X != "${1}"X || echo 'something wrong during fetching certificat of rvm'

  echo 'quit with error '$1
  
  pkill -9 -f $ret_log
  exit 1

}

./tail_ret.sh $ret_log &
 
wget http://curl.haxx.se/ca/cacert.pem > $ret_log 2>&1

test $? -eq 0 || err_quit 'downloading cert for rvm failed'

echo 'wget done with success !'  

mv -f cacert.pem ca-bundle.crt >> $ret_log 2>&1 

test $? -eq 0 || err_quit 'renaming cert file error'

echo 'renaming cert file done with success !'

mv -f ca-bundle.crt /etc/pki/tls/certs/ >> $ret_log 2>&1

test $? -eq 0 || err_quit 'moving cert file to /etc/pki/tls/certs/'

echo 'moving cert file to /etc/pki/tls/certs/ done with success !'

pkill -9 -f $ret_log 
