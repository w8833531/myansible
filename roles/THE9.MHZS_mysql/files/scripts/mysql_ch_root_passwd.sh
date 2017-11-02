#!/bin/bash
dbpasswd=`cat ~/.mysql_secret | grep password | awk '{print $18}'`
if [ -z $dbpasswd ]; then
	/usr/bin/mysql -uroot  -e "set password=PASSWORD('Abcd'); set password for 'root'@'localhost'=PASSWORD('Abcd'); set password for 'root'@'127.0.0.1'=PASSWORD('Abcd');"
else
	/usr/bin/mysql -uroot -p$dbpasswd -e "set password=PASSWORD('Abcd'); set password for 'root'@'localhost'=PASSWORD('Abcd');set password for 'root'@'127.0.0.1'=PASSWORD('Abcd');"
fi

