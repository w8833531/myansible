#!/bin/bash
#Mysql autobackup shell
#auth: lixin 
#date: 2015-09-18
#  GRANT SELECT, RELOAD, LOCK TABLES, REPLICATION CLIENT, SHOW VIEW ON *.* TO 'backup'@'localhost' 
#00 03 * * * /bin/bash /root/scripts/mysql_backup2.sh

#-------------------
dbuser=backup
dbpasswd=
dbserver=localhost
dbport=3306
dbopt="-R -f -F --lock-tables --dump-slave=2 --default-character-set=utf8"
backupdir=/data/mysql/backup
bindir=/usr/bin
backupmon=$(date +%Y%m)

backupdir02=$backupdir/$backupmon

backuptime=$(date +%Y%m%d_%H%M%S)
keepdays=90


#-------------------
logfile=$backupdir/baklogs/mysqlbackup-`date +%Y%m%d_%H%M%S`.log
logtmp=$backupdir/mybackup.tmp

#===============================================

if [ ! -d $backupdir02 ]
then
        echo "$backupdir02 is not exist, then make ..." > $logfile
        mkdir -p $backupdir02
fi

echo "start====================================>">>$logfile
echo "Beginning backup `date '+%F %T'`" >>$logfile

for database in $($bindir/mysql -u$dbuser -e "show databases;" | grep -v "Database\|mysql\|information_schema\|performance_schema\|dba\|pmon\|mu_log\|mu_dw")
do
	if [ -z $dbpasswd ]
	then
		$bindir/mysqldump -u$dbuser -h$dbserver -P$dbport $dbopt --databases $database >$backupdir02/${database}_${backuptime}.sql
	else
	    $bindir/mysqldump -u$dbuser -p$dbpasswd -h$dbserver -P$dbport $dbopt $database >$backupdir02/${database}_${backuptime}.sql
	fi
	
    tar czvf $backupdir02/${database}_${backuptime}.tar.gz $backupdir02/${database}_${backuptime}.sql >>$logfile 2>&1
    echo "$backupdir02/${database}_${backuptime}.tar.gz Backup Success!" >>$logfile
    rm -fr $backupdir02/${database}_${backuptime}.sql
	
done

echo "Delete $keepdays days ago files ..." >>$logfile

find $backupdir -mtime +$keepdays -fls $logtmp -exec rm {} \;

echo "Deleted Backup file is :">>$logfile
cat $logtmp >>$logfile
echo "Delete old file Success!" >>$logfile


echo "Finishing backup `date '+%F %T'`" >>$logfile
echo "End=======================================">>$logfile

