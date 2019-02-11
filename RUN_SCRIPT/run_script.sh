#!/bin/bash

#For individual servers
connection_user=eldar
connection_pass=$(cat ./password | awk '{print $1}')
#	echo "Please type the agent name"
#	read agentname
#	echo "Please type the server name"
#	read hostname

#./agents.exp $connection_user $connection_pass $hostname $agentname

#For a few hosts


echo "IF YOU WANT TO RUN COMMANDS IN PARALLEL PRESS y "
read parallel


cp /home/eldar/script/RUN_SCRIPT/myscript.sh /home/eldar/script/uploads/myscript.sh

#for hostname in $(cat ./agents_hosts | awk '{print $1}')
for hostname in $(cat ./hosts | awk '{print $1}')

do
#	username=$(grep -e $hostname'[[:blank:]]' ./hosts_with_pw.lst | awk '{print $2}');
#	password=$(grep -e $hostname'[[:blank:]]' ./hosts_with_pw.lst | awk '{print $3}');

#	./agents.exp $username $password $hostname $agentname



#hostname=$(grep -e $hostname'[[:blank:]]' ./hosts | awk '{print $2}');

if [ "$parallel" = "y" ] || [ "$parallel" = "yes" ] || [ "$parallel" = "Y" ] || [ "$parallel" = "YES" ]
then
        gnome-terminal --working-directory=/home/eldar/script -x bash -c " ./scp.exp $connection_user $connection_pass $hostname 'myscript.sh'; ./RUN_SCRIPT/script.exp $connection_user $connection_pass $hostname; ./scp_download.exp $connection_user $connection_pass $hostname 'myscript.out';  bash"
else
	./scp.exp $connection_user $connection_pass $hostname 'myscript.sh'; ./RUN_SCRIPT/script.exp $connection_user $connection_pass $hostname; ./scp_download.exp $connection_user $connection_pass $hostname 'myscript.out';
fi

done 

mv /home/eldar/script/downloads/*out* /home/eldar/script/downloads/TEMP; cd /home/eldar/script/downloads/TEMP; sed -i.bak '/nohup/d' ./*out*; rm *.bak;

