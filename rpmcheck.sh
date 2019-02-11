#!/bin/bash
#For individual servers
connection_user=eldar
connection_pass=$(cat ./password | awk '{print $1}')


cp /home/eldar/script/TASKS/secfixdb.RedHat6Server /home/eldar/script/uploads/secfixdb.RedHat6Server
cp /home/eldar/script/TASKS/secfixdb.RedHat7Server /home/eldar/script/uploads/secfixdb.RedHat7Server
cp /home/eldar/script/TASKS/secfixdb.SLES11-SP4_x86 /home/eldar/script/uploads/secfixdb.SLES11-SP4_x86
cp /home/eldar/script/TASKS/secfixdb.SLES11-SP4_x86_64 /home/eldar/script/uploads/secfixdb.SLES11-SP4_x86_64


echo "IF YOU WANT TO GET ONLY RPM INFO PRESS y"
read rpmanswer
echo "IF YOU WANT TO RUN COMMANDS IN PARALLEL PRESS y "
read parallel


if [ "$rpmanswer" = "y" ] || [ "$rpmanswer" = "yes" ] || [ "$rpmanswer" = "Y" ] || [ "$rpmanswer" = "YES" ]
then
#For a few hosts
for hostname in $(cat ./hosts | awk '{print $1}')
do
#       username=$(grep -e $hostname'[[:blank:]]' ./hosts_with_pw.lst | awk '{print $2}');
#       password=$(grep -e $hostname'[[:blank:]]' ./hosts_with_pw.lst | awk '{print $3}');

#       ./getupdates.exp $username $password $hostname

# FOR LDAP PASSWORDS
if [ "$parallel" = "y" ] || [ "$parallel" = "yes" ] || [ "$parallel" = "Y" ] || [ "$parallel" = "YES" ]
then
        gnome-terminal --working-directory=/home/eldar/script -x bash -c "./rpmcheck.exp $connection_user $connection_pass $hostname; ./scp_download.exp $connection_user $connection_pass $hostname rpm.lst; bash"
        
else
        ./rpmcheck.exp $connection_user $connection_pass $hostname; ./scp_download.exp $connection_user $connection_pass $hostname rpm.lst;
fi

done

else


#For a few hosts
for hostname in $(cat ./hosts | awk '{print $1}')
do
#       username=$(grep -e $hostname'[[:blank:]]' ./hosts_with_pw.lst | awk '{print $2}');
#       password=$(grep -e $hostname'[[:blank:]]' ./hosts_with_pw.lst | awk '{print $3}');

#       ./getupdates.exp $username $password $hostname

# FOR LDAP PASSWORDS
if [ "$parallel" = "y" ] || [ "$parallel" = "yes" ] || [ "$parallel" = "Y" ] || [ "$parallel" = "YES" ]
then
        gnome-terminal --working-directory=/home/eldar/script -x bash -c "./scp.exp $connection_user $connection_pass $hostname 'APAR_check.sh'; ./scp.exp $connection_user $connection_pass $hostname 'lssecfixes'; ./scp.exp $connection_user $connection_pass $hostname 'secfixdb.RedHat6Server'; ./scp.exp $connection_user $connection_pass $hostname 'secfixdb.RedHat7Server'; ./scp.exp $connection_user $connection_pass $hostname 'secfixdb.SLES11-SP4_x86'; ./scp.exp $connection_user $connection_pass $hostname 'secfixdb.SLES11-SP4_x86_64'; ./rpmcheck.exp $connection_user $connection_pass $hostname; ./scp_download.exp $connection_user $connection_pass $hostname rpm.lst; ./scp_download.exp $connection_user $connection_pass $hostname apar.out; bash"
	
else
	./scp.exp $connection_user $connection_pass $hostname 'APAR_check.sh'; ./scp.exp $connection_user $connection_pass $hostname 'lssecfixes'; ./scp.exp $connection_user $connection_pass $hostname 'secfixdb.RedHat6Server'; ./scp.exp $connection_user $connection_pass $hostname 'secfixdb.RedHat7Server'; ./scp.exp $connection_user $connection_pass $hostname 'secfixdb.SLES11-SP4_x86'; ./scp.exp $connection_user $connection_pass $hostname 'secfixdb.SLES11-SP4_x86_64'; ./rpmcheck.exp $connection_user $connection_pass $hostname; ./scp_download.exp $connection_user $connection_pass $hostname rpm.lst; ./scp_download.exp $connection_user $connection_pass $hostname apar.out

fi

done

fi



echo "When the download completed PRESS y "
read answer
if [ "$answer" = "y" ] || [ "$answer" = "yes" ] || [ "$answer" = "Y" ] || [ "$answer" = "YES" ]
then

cd /home/eldar/script/downloads
mv rpm.lst* RPMs
cd RPMs
cat rpm.lst* > `date "+%d-%m-%Y"`.rpm.lst
cd ..
mv apar.out* APARS
cd APARS
cat apar.out* > `date "+%d-%m-%Y"`.apar.out

else
exit 1
fi
