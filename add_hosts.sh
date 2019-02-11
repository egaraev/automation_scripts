#!/bin/bash
agent=$1 
localfile=$2
remotefile=$3
scriptname=$4


#emptying the hosts file
echo '' > hosts
sed '1d' hosts > tmpfile; mv tmpfile hosts

if [ "$agent" -eq "1" ]
then
echo "Please type the agent name and server name"
else 
echo "Please type the server name"
fi

read  agent_server_name

echo "$agent_server_name" >> hosts
while [[ ! -z $agent_server_name ]] 
do
read agent_server_name
echo "$agent_server_name" >> hosts
done




if [ "$agent" -eq "1" ]
then
./Agent/agents.sh
fi 


if [ "$agent" -eq "2" ]
then
#fab putfile:/home/eldar/script/uploads/$2,/home/plzz011x/$3
./scp.sh
fi


if [ "$agent" -eq "3" ]
then
#fab getfile:/home/plzz011x/$3,/home/eldar/script/downloads/$2
./scp_download.sh
fi


if [ "$agent" -eq "4" ]
then
./RUN_SCRIPT/run_script.sh
fi


if [ "$agent" -eq "5" ]
then
./RHEL_PCI/update_rhel.sh
fi


if [ "$agent" -eq "6" ]
then
./runcommand.sh
fi


if [ "$agent" -eq "7" ]
then
./rpmcheck.sh
fi


if [ "$agent" -eq "8" ]
then
./SLES_PCI/update_sles.sh
fi


if [ "$agent" -eq "9" ]
then
./runfabcommand.sh
fi



if [ "$agent" -eq "10" ]
then
./RHEL_PCI/update_rhel_rbt.sh
fi




if [ "$agent" -eq "11" ]
then
./SLES_PCI/update_sles_rbt.sh
fi




if [ "$agent" -eq "12" ]
then
#fab putfile:/home/eldar/script/TASKS/tsm.sh,/home/plzz011x/tsm.sh
./TASKS/tsm_check.sh
fi


if [ "$agent" -eq "13" ]
then
./mailfix.sh
fi

if [ "$agent" -eq "14" ]
then
./TASKS/swap_check.sh
fi


if [ "$agent" -eq "15" ]
then
./TASKS/ntpcheck.sh
fi



if [ "$agent" -eq "16" ]
then
./TASKS/scmcheck.sh
fi




