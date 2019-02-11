#!/bin/bash
#For individual servers
connection_user=eldar
connection_pass=$(cat ./password | awk '{print $1}')
copyhost=someserver1

echo "someserver" > ./hosts
echo "someserver1" >> ./hosts


#COPYING THE DATE FROM RHEL TO SUSE servers

#./copydate.exp $connection_user $connection_pass $copyhost

#For a few hosts
for hostname in $(cat ./hosts | awk '{print $1}')
do
#       username=$(grep -e $hostname'[[:blank:]]' ./hosts_with_pw.lst | awk '{print $2}');
#       password=$(grep -e $hostname'[[:blank:]]' ./hosts_with_pw.lst | awk '{print $3}');

#       ./getupdates.exp $username $password $hostname

# FOR LDAP PASSWORDS
./getpackages.exp $connection_user $connection_pass $hostname
done




for i in 2
do
fab getfile:/home/eldar/package.lst,/home/eldar/script/downloads/package.lst
done

cat ./downloads/package.lst.someserver >> ./downloads/package.lst.someserver1
rm ./downloads/package.lst.someserver
