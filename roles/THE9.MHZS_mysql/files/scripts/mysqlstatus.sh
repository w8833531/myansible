#!/bin/bash
#author ZEROMAX 20091223
#Useage:This script use to mysql status to file Mysql.Info

mysqlbinpath=/usr/bin/
countpath=/opt/status/
dbuser=root


#statusarray first colume 'infoname' second colume 'commandname' third colume 'cale per second ? 1 or 0' , please leave a blank space at every line's end! 

statusarray=(
"table_locks_waited:Table_locks_waited:0" 
"innodb_row_lock_waits:Innodb_row_lock_waits:0" 
"table_locks_pers:Table_locks_immediate:1" 
"call_procedue_pers:Com_call_procedure:1" 
"delete_pers:Com_delete:1" 
"insert_pers:Com_insert:1" 
"insert_select_pers:Com_insert_select:1" 
"replace_pers:Com_replace:1" 
"select_pers:Com_select:1" 
"update_pers:Com_update:1" 
"update_multi_pers:Com_update_multi:1" 
"qps:Queries:1" 
"tps:Handler_commit:1" 
)


i=0
n=${#statusarray[*]}
while [ $i -lt $n ]
do
	t1=`echo ${statusarray[$i]} | cut -d: -f1`
	t2=`echo ${statusarray[$i]} | cut -d: -f2`
	t3=`echo ${statusarray[$i]} | cut -d: -f3`
	if [ $t3 = 1 ];then
		old=`cat ${countpath}Mysql_${t2}.txt`
		oldtime=`date +%s -r ${countpath}Mysql_${t2}.txt`
		${mysqlbinpath}mysql -e"show global status like '${t2}'" | sort | head -1 | awk '{print $2}' > ${countpath}Mysql_${t2}.txt
		new=`cat ${countpath}Mysql_${t2}.txt`
		newtime=`date +%s -r ${countpath}Mysql_${t2}.txt`
		if [[ $newtime = $oldtime ]];then
			values=0
		else
			values=`expr \( ${new} - ${old} \) / \( ${newtime} - ${oldtime} \)`
		fi	
	else
		values=`${mysqlbinpath}mysql -e"show global status like '${t2}'" | sort | head -1 | awk '{print $2}'`
	fi
	
	if [ $i = 0 ];then
			echo "Mysql.${t1}=${values}" > ${countpath}Mysql.Info.tmp
	else
			echo "Mysql.${t1}=${values}" >> ${countpath}Mysql.Info.tmp
	fi
	
	i=`expr $i + 1`
done
cat ${countpath}Mysql.Info.tmp > ${countpath}Mysql.Info
rm -fr ${countpath}Mysql.Info.tmp
