#!/bin/bash

ret_log='result.log'

./tail_ret.sh $ret_log &

err_quit(){

  test ""X != "${1}"X || echo 'something wrong during fetching certificat of rvm'

  echo 'quit with error '$1
  
  pkill -9 -f $ret_log
  exit 1

}

sudo curl -L get.rvm.io | bash -s stable

test $? -eq 0 || err_quit 'installing rvm failed !'

source ~/.bashrc

source ~/.bash_profile

source ~/.rvm/scripts/rvm

sed -i -e 's/ftp\.ruby-lang\.org\/pub\/ruby/ruby\.taobao\.org\/mirros\/ruby/g' ~/.rvm/config/db

pkill -9 -f $ret_log



