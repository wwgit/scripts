#!/bin/bash

#$1 is mysql source dir
cmake $1 -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/data/mysql \
		-DSYSCONFDIR=/etc -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 \
		-DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWITH_FEDERATED_STORAGE_ENGINE=1 \
		-DWITH_PARTITION_STORAGE_ENGIE=1 -DMYSQL_UNIX_ADDR=/tmp/mysqld.sock \
		-DENABLED_LOCAL_INFILE=1 -DEXTRA_CHARSETS=all \
		-DMYSQL_USER=mysql

useradd mysql -s /sbin/nologin
cat /etc/passwd | grep mysql
cat /etc/group | grep mysql

#build
gmake

#install
make install

cp -rf mysql.server /etc/init.d/mysql

#my.cnf content
#
#
cp -rf my-default.cnf /etc/my.cnf

vim /etc/my.cnf
basedir=/user/local/mysql
datadir=/data/mysql
port=3306
socket=/tmp/mysqld.sock
log-error=/data/logs/error.log
pid-file=/data/mysqld.pid

#init mysql db for 5.6
./scripts/mysql_install_db --basedir=/user/local/mysql/ \
						   --datadir=/data/mysql/ \
						   --user=mysql
#for 5.7
mysqld --defaults-file=/etc/my.cnf --user=mysql --initialize --initialize-insecure

vim ~/.bash_profile
PATH=$path:/usr/local/mysql/bin
export PATH
source ~/.bash_profile

#mysql RPM source install
#
useradd tubeliu
cp source.rpm /home/tubeliu
rpmbuild ~

#vim rpm.spec

#rpm build - need gperf rpm, libaio-devel
rpmbuild -bb mysql.spec



