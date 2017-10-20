#!/bin/bash
#This script use to install mysql-5.6.25 
install_dir = ~/mysql
### make a install dir 
if [ ! -d ${install_dir} ]
then
	mkdir ~/mysql
fi
cd ${install_dir}
### wget install mysql rpm 
wget http://dev.mysql.com/get/Downloads/MySQL-5.6/MySQL-5.6.25-1.linux_glibc2.5.x86_64.rpm-bundle.tar
tar xvf MySQL-5.6.25-1.linux_glibc2.5.x86_64.rpm-bundle.tar
mkdir rpm
mv *.rpm rpm/
cd rpm
### remove all mysql installed
for i in `rpm -qa | grep -i mysql`
do
   rpm -e $i --nodeps
done
### install mysql
groupadd mysql
useradd -g mysql mysql
mkdir -p /data/mysql/data  /data/mysql/backup/baklogs /var/lib/mysql
chown -R mysql:mysql /data/mysql/data
chown -R mysql:mysql /data/mysql
rpm -ivh MySQL-server-5.6.25-1.linux_glibc2.5.x86_64.rpm MySQL-client-5.6.25-1.linux_glibc2.5.x86_64.rpm MySQL-devel-5.6.25-1.linux_glibc2.5.x86_64.rpm
### start mysql
service mysql start
