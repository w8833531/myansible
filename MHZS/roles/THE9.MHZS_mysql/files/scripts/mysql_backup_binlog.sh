#!/bin/bash
#Mysql binlog backup shell
#auth: lixin 
#date: 2017-09-06
#  GRANT SELECT, RELOAD, LOCK TABLES, REPLICATION CLIENT, SHOW VIEW ON *.* TO 'backup'@'localhost' 
#*/30 * * * * /bin/bash /root/scripts/mysql_backup_binlog.sh

#-------------------
datadir=/data/mysql/data

backupdir=/data/mysql/backup/binlog
bindir=/usr/bin
backupmon=$(date +%Y%m)
backupday=$(date +%Y%m%d)

backupdir03=$backupdir/$backupmon/$backupday

backuptime=$(date +%Y%m%d_%H%M%S)
keepdays=60

#-------------------
logfile=$backupdir/baklogs/mysqlbackup-`date +%Y%m%d_%H%M%S`.log
logtmp=$backupdir/mybackup.tmp

#===============================================

if [ ! -d $backupdir03 ]
then
        echo "$backupdir03 is not exist, then make ..." > $logfile
        mkdir -p $backupdir03
fi

echo "start====================================>">>$logfile
echo "Beginning binlog backup `date '+%F %T'`" >>$logfile

mysqladmin -ubackup flush-logs

find $datadir -name "bin-log.*" -mmin -31 | xargs tar czvf $backupdir03/bin-log_${backuptime}.tar.gz >>$logfile 2>&1
echo "$backupdir03/bin-log_${backuptime}.tar.gz Backup Success!" >>$logfile

echo "Delete $keepdays days ago files ..." >>$logfile

find $backupdir -mtime +$keepdays -fls $logtmp -exec rm {} \;

echo "Deleted Binlog Backup file is :">>$logfile
cat $logtmp >>$logfile
echo "Delete old file Success!" >>$logfile


echo "Finishing binlog backup `date '+%F %T'`" >>$logfile
echo "End=======================================">>$logfile


