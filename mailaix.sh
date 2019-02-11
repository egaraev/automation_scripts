#!/bin/bash

#For individual servers
connection_user=plzz011x
connection_pass=$(cat ./password | awk '{print $1}')
#        echo "Please type the server name"
#        read hostname

#./passwd.exp $connection_user $connection_pass $hostname

#For a few hosts
for hostname in $(cat ./hosts | awk '{print $1}')
do
#       username=$(grep -e $hostname'[[:blank:]]' ./hosts_with_pw.lst | awk '{print $2}');
#       password=$(grep -e $hostname'[[:blank:]]' ./hosts_with_pw.lst | awk '{print $3}');

#       ./passwd.exp $username $password $hostname

# FOR LDAP PASSWORDS
./mailaix.exp $connection_user $connection_pass $hostname


done


