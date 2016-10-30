#!/bin/bash


echo 'beginning to remove rvm application...'
rm -rf $HOME/.rvm $HOME/.rvmrc /etc/rvmrc /etc/profile.d/rvm.sh /usr/local/rvm /usr/local/bin/rvm
#/usr/sbin/groupdel rvm
echo 'removing rvm application done...'


#echo 'beginning to remove rvm related info from bashrc, profile,zshrc,bash_profile...'
#find $HOME -name '.bashrc' | xargs sed -i 's/export.*\.rvm.*ADD RVM to PATH for scripting//g'
#
#find $HOME -name '.profile' | xargs sed -i 's/EXPORT\|export.*\.rvm\/.*ADD RVM to PATH for scripting//g'
#
#find $HOME -name '.zshrc' | xargs sed -i 's/EXPORT\|export.*\.rvm\/.*ADD RVM to PATH for scripting//g'
#
#find $HOME -name '.profile' | xargs sed -i 's/\[\[.*\/\.rvm\/.*\]\].*Load RVM into a shell session \*as a function\*//g'
#
#find $HOME -name '.bash_profile' | xargs sed -i 's/\[\[.*\/\.rvm\/.*\]\].*Load RVM into a shell session \*as a function\*//g'
#echo 'removing rvm related info done'
#EXPORT PATH="$PATH:$HOME/.rvm/bin"
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

#find . -name "run.sh" | xargs sed -i 's/-Djava.rmi.server.hostname=192.168.220.151/-Djava.rmi.server.hostname=192.168.220.150/g'
#find . -name "config.properties" | xargs sed -i 's/1.1.1.31:2181/1.1.1.150:2181/g'
#insert into table1 select * from table2
find /home/tomcat/lpt10/tomcat-params/conf -name "server.xml" | xargs sed -i 's/port=\"[0-9]\{4\}\" protocol=\"HTTP\/1\.1\"/port=\"7089\" protocol=\"HTTP\/1\.1\"/'
