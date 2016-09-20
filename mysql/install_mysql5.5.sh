#!/bin/bash
# mysql install 
DB_PASS=${DB_PASS:-upyun.com}
MYSQL_DIR=/usr/local/mysql
MYSQL_DATA=/date/mysql/data
MYSQL_LOG=/date/mysql/log
USERNAME=mysql
GROUP=mysql
MYSQL_UP="/usr/local/mysql/bin/mysql -u root -h localhost --password=$DB_PASS" 
###
grep $USERNAME  /etc/passwd >/dev/null
if [ $? -eq 1 ];then
groupadd $GROUP 
useradd -g $USERNAME $GROUP -s /sbin/nolgoin/
fi

mkdir -p /date/mysql/{data,log}
mkdir -p /usr/local/mysql

##################
cd /root
if [ -f mysql-5.5.40-linux2.6-x86_64.tar.gz ];then
tar zxvf mysql-5.5.40-linux2.6-x86_64.tar.gz
mv -f mysql-5.5.40-linux2.6-x86_64/* /usr/local/mysql/
else
wget http://zy-res.oss-cn-hangzhou.aliyuncs.com/mysql/mysql-5.5.40-linux2.6-x86_64.tar.gz > /dev/null  2>&1
tar zxvf mysql-5.5.40-linux2.6-x86_64.tar.gz
mv -f mysql-5.5.40-linux2.6-x86_64/* /usr/local/mysql/ > /dev/null 2>&1
fi

rm -fr ./mysql*


#cp -f /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld
#sed -i 's#^basedir=$#basedir='$MYSQL_DIR'#' /etc/init.d/mysqld
#sed -i 's#^datadir=$#datadir='$MYSQL_DATA'#' /etc/init.d/mysqld
cp -f /usr/local/mysql/support-files/my-medium.cnf /etc/my.cnf
sed -i 's#skip-external-locking#skip-external-locking\nlog-error='$MYSQL_LOG'/error.log#' /etc/my.cnf
sed -i '/^\[mysqld\]/adatadir = /date/mysql/data' /etc/my.cnf
sed -i '/^\[mysqld\]/abasedir = /usr/local/mysql' /etc/my.cnf
#chmod 755 /etc/init.d/mysqld


