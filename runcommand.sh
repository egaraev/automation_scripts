#!/bin/bash

#For individual servers
connection_user=eldar
connection_pass=$(cat ./password | awk '{print $1}')
        echo "Please type the command"
        read command

#./rpmcheck.exp $connection_user $connection_pass $hostname

echo "IF YOU WANT TO RUN COMMANDS IN PARALLEL PRESS y "
read parallel


#For a few hosts
for hostname in $(cat ./hosts | awk '{print $1}')
do
#       username=$(grep -e $hostname'[[:blank:]]' ./hosts_with_pw.lst | awk '{print $2}');
#       password=$(grep -e $hostname'[[:blank:]]' ./hosts_with_pw.lst | awk '{print $3}');

#       ./rpmcheck.exp $username $password $hostname

# FOR LDAP PASSWORDS

if [ "$parallel" = "y" ] || [ "$parallel" = "yes" ] || [ "$parallel" = "Y" ] || [ "$parallel" = "YES" ]
then
        gnome-terminal --working-directory=/home/eldar/script -x bash -c "./runcommand.exp $connection_user $connection_pass $hostname '$command'; bash"
	#tmux ./runcommand.exp $connection_user $connection_pass $hostname '$command'; bash
else
        ./runcommand.exp $connection_user $connection_pass $hostname "$command"
fi




#./runcommand.exp $connection_user $connection_pass $hostname "$command"
#gnome-terminal -e "./runcommand.exp $connection_user $connection_pass $hostname '$command'"

done



