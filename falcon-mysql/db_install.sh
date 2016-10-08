#!/bin/bash
DB_PASS=${DB_PASS:-upyun.com}
MYSQL_DIR=/usr/local/mysql
MYSQL_DATA=/date/mysql/data
MYSQL_LOG=/date/mysql/log
MYSQL_UP="/usr/local/mysql/bin/mysql -u root -h localhost --password=$DB_PASS"

mkdir -p /date/mysql/{data,log,redis}
chown -R mysql.mysql  /usr/local/mysql
chown -R mysql.mysql /date/mysql
chown root.root /date/mysql/redis

####
echo "===========================> Install Mysql_db "
/usr/local/mysql/scripts/mysql_install_db --user=mysql  --datadir=/date/mysql/data --basedir=/usr/local/mysql

#####
echo "============================> Start and Changge Password"
/usr/local/mysql/bin/mysqld_safe --user mysql > /dev/null 2>&1 &
sleep 2
#######################
/usr/local/mysql/bin/mysqladmin -u root --password=''  password $DB_PASS
$MYSQL_UP -e "grant all on *.* to 'root'@'%' identified by '$DB_PASS'"

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

tar zxvf /root/redis.tar.gz -C /usr/local/ ; sleep 1 ; rm -fr /root/redis.tar.gz &&  rm -fr /root/scripts

/usr/local/redis-2.8.6/bin/redis-server  /usr/local/redis-2.8.6/redis.falcon.conf



