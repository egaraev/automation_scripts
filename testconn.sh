#!/bin/bash
#set -xv

#emptying the hosts file
echo '' > testhosts
sed '1d' testhosts > tmphosts; mv tmphosts testhosts

echo "Please write the server name"
read  server_name

echo "$server_name" >> testhosts
while [[ ! -z $server_name ]] 
do
read server_name
echo "$server_name" >> testhosts
done
echo "Starting test"

starttime=$(date "+%s")


while true; do

for host in $(cat testhosts)
do
	while true; do
	ssh -o ConnectTimeOut=7 -o BatchMode=yes $host >testconn.tmp 2>&1
	result=`cat testconn.tmp | head -1 | awk '{print $1}'`
	if [ $result == "Permission" ] 
	then
	echo "$host is available"
	#sed -i.bak "/$host/d" ./testhosts
	break
	else	
	currtime=$(date "+%s")
	((down = (starttime - currtime) / 60))
	echo "$host is unavailable already $down minutes" | sed 's/-//g'
	break
	fi
	done 
done

done
