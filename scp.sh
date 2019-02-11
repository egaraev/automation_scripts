#!/bin/bash

#For individual servers
connection_user=eldar
connection_pass=$(cat ./password | awk '{print $1}')
        echo "Please type the local filename"
        read filename
	#echo "Please type the remote filename"
	#read filename_rmt

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
        gnome-terminal --working-directory=/home/eldar/script -x bash -c "./scp.exp $connection_user $connection_pass $hostname '$filename'; bash"
else
        ./scp.exp $connection_user $connection_pass $hostname "$filename"
fi


done



