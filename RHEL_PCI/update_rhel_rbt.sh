#!/bin/bash

connection_user=eldar
connection_pass=$(cat ./password | awk '{print $1}')

echo "IF YOU WANT TO RUN COMMANDS IN PARALLEL PRESS y "
read parallel


for hostname in $(cat ./hosts | awk '{print $1}')
do
if [ "$parallel" = "y" ] || [ "$parallel" = "yes" ] || [ "$parallel" = "Y" ] || [ "$parallel" = "YES" ]
then
        gnome-terminal --working-directory=/home/eldar/script -x bash -c "./RHEL_PCI/update_rhel_rbt.exp $connection_user $connection_pass $hostname; bash"
else
	./RHEL_PCI/update_rhel_rbt.exp $connection_user $connection_pass $hostname
fi


done
