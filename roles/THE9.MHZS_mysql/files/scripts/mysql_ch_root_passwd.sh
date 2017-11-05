#!/bin/bash
#Author: Wu Ying
#Usage: change mysql db root password when finished mysql server install
#Date: 2017-11-3

### read mysql installed password from ~/.mysql_secret
dbpasswd=`cat ~/.mysql_secret | grep password | awk '{print $18}'`

### read new mysql password from command line
new_dbpasswd="'$1'"

### if no password in command line ,use default password
if [ -z $new_dbpasswd ];then
	new_dbpasswd="'Abcd=1234'"
fi

### set root password cmd
sql_cmd="set password=PASSWORD(${new_dbpasswd}); set password for 'root'@'localhost'=PASSWORD(${new_dbpasswd}); set password for 'root'@'127.0.0.1'=PASSWORD(${new_dbpasswd}); set password for 'root'@'::1'=PASSWORD(${new_dbpasswd});"

if [ -z $dbpasswd ]; then
	/usr/bin/mysql -uroot  -e "${sql_cmd}"
else
	/usr/bin/mysql -uroot -p$dbpasswd -e "${sql_cmd}"
fi

