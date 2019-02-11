#!/bin/bash

#For individual servers
connection_user=eldar
connection_pass=$(cat ./password | awk '{print $1}')


#emptying the script file
echo '' > myscript
sed '1d' myscript > tmpscriptfile; mv tmpscriptfile myscript
sed -i.bak '/run (/d' ./fabfile.py > /dev/null

echo "Please type the commands"
read commands
echo "$commands" >> myscript
while [[ ! -z $commands ]] 
do
read commands
echo "$commands" >> myscript
done

for commands in "$(cat ./myscript | awk '{print "\trun (\""$0"\")"}')"
do
echo "$commands" >>./fabfile.py
done

sed -i.bak '/run ("")/d' ./fabfile.py > /dev/null






#./rpmcheck.exp $connection_user $connection_pass $hostname



#For a few hosts
#for hostname in $(cat ./hosts | awk '{print $1}')
#do
#       username=$(grep -e $hostname'[[:blank:]]' ./hosts_with_pw.lst | awk '{print $2}');
#       password=$(grep -e $hostname'[[:blank:]]' ./hosts_with_pw.lst | awk '{print $3}');

#       ./rpmcheck.exp $username $password $hostname

# FOR LDAP PASSWORDS

fab runcommand

#done




