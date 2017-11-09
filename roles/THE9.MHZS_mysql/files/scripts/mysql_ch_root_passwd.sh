#!/bin/bash
#Author: Wu Ying
#Usage: change mysql db root password when finished mysql server install
#Date: 2017-11-3


### read new mysql password from command line
new_dbpasswd="'$1'"
old_dbpasswd="$2"

### if no password in command line ,use default password
if [ -z $new_dbpasswd ];then
	new_dbpasswd="'The9!NewPass'"
fi

### read mysql default installed password from ~/.mysql_secret or use new password
if [ -f ~/.mysql_secret ]; then
	dbpasswd=`cat ~/.mysql_secret | grep password | awk '{print $18}'`
else
	dbpasswd=${old_dbpasswd}
fi

### set root password cmd
sql_cmd="set password=PASSWORD(${new_dbpasswd}); set password for 'root'@'localhost'=PASSWORD(${new_dbpasswd}); set password for 'root'@'127.0.0.1'=PASSWORD(${new_dbpasswd}); set password for 'root'@'::1'=PASSWORD(${new_dbpasswd});"

if [ -z $dbpasswd ]; then
	/usr/bin/mysql -uroot  -e "${sql_cmd}"
else
	/usr/bin/mysqladmin -uroot -p$dbpasswd password ${new_dbpasswd}
	/usr/bin/mysql -uroot -p${new_dbpasswd} -e "${sql_cmd}"
fi
### delete mysql default installed password file
if [ -f ~/.mysql_secret ]; then
	rm -f ~/.mysql_secret
fi
