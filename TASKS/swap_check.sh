#!/bin/bash
#individual servers
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

cp /home/eldar/script/TASKS/swap.sh /home/eldar/script/uploads/swap.sh

#for hostname in $(cat ./agents_hosts | awk '{print $1}')
for hostname in $(cat ./hosts | awk '{print $1}')

do
#	username=$(grep -e $hostname'[[:blank:]]' ./hosts_with_pw.lst | awk '{print $2}');
#	password=$(grep -e $hostname'[[:blank:]]' ./hosts_with_pw.lst | awk '{print $3}');

#	./agents.exp $username $password $hostname $agentname



#hostname=$(grep -e $hostname'[[:blank:]]' ./hosts | awk '{print $2}');

if [ "$parallel" = "y" ] || [ "$parallel" = "yes" ] || [ "$parallel" = "Y" ] || [ "$parallel" = "YES" ]
then
        gnome-terminal --working-directory=/home/eldar/script -x bash -c "./scp.exp $connection_user $connection_pass $hostname 'swap.sh'; ./TASKS/swap_check.exp $connection_user $connection_pass $hostname; bash"
else

./scp.exp $connection_user $connection_pass $hostname 'swap.sh'; ./TASKS/swap_check.exp $connection_user $connection_pass $hostname

fi

done

