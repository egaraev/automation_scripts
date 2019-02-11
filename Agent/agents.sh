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



#for hostname in $(cat ./agents_hosts | awk '{print $1}')
for agentname in $(cat ./hosts | awk '{print $1}')

do
#	username=$(grep -e $hostname'[[:blank:]]' ./hosts_with_pw.lst | awk '{print $2}');
#	password=$(grep -e $hostname'[[:blank:]]' ./hosts_with_pw.lst | awk '{print $3}');

#	./agents.exp $username $password $hostname $agentname



hostname=$(grep -e $agentname'[[:blank:]]' ./hosts | awk '{print $2}');
#./Agent/agents.exp $connection_user $connection_pass $agentname $hostname


if [ "$parallel" = "y" ] || [ "$parallel" = "yes" ] || [ "$parallel" = "Y" ] || [ "$parallel" = "YES" ]
then
        gnome-terminal -e "./Agent/agents.exp $connection_user $connection_pass $agentname $hostname"
else
        ./Agent/agents.exp $connection_user $connection_pass $agentname $hostname
fi



#echo $agentname $hostname


done

