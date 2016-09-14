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

rm  ./mysql-5.5.40-linux2.6-x86_64.tar.gz

chown -R mysql.mysql  /usr/local/mysql
chown -R mysql.mysql /date/mysql
######

cp -f /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld
sed -i 's#^basedir=$#basedir='$MYSQL_DIR'#' /etc/init.d/mysqld
sed -i 's#^datadir=$#datadir='$MYSQL_DATA'#' /etc/init.d/mysqld
cp -f /usr/local/mysql/support-files/my-medium.cnf /etc/my.cnf
sed -i 's#skip-external-locking#skip-external-locking\nlog-error='$MYSQL_LOG'/error.log#' /etc/my.cnf
/usr/local/mysql/scripts/mysql_install_db --user=mysql --datadir=/date/mysql/data --basedir=/usr/local/mysql
sed -i '/^\[mysqld\]/adatadir = /date/mysql/data' /etc/my.cnf
sed -i '/^\[mysqld\]/abasedir = /usr/local/mysql' /etc/my.cnf
chmod 755 /etc/init.d/mysqld


/etc/init.d/mysqld start 

sleep 1
/usr/local/mysql/bin/mysqladmin -u root --password=''  password $DB_PASS

cd $(mkdir /root/falcon_db)
git clone https://github.com/open-falcon/scripts.git 
cd ./scripts/
$MYSQL_UP < db_schema/graph-db-schema.sql
$MYSQL_UP < db_schema/dashboard-db-schema.sql
$MYSQL_UP < db_schema/portal-db-schema.sql
$MYSQL_UP < db_schema/links-db-schema.sql
$MYSQL_UP < db_schema/uic-db-schema.sql

sleep 1
rm -fr /root/falcon_db
