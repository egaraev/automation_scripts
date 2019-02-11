#!/bin/bash
date --date="`cat pcifreezedate | tail -1`" +%s > pcitimeseconds
pcitime=$(cat pcitimeseconds)
now=$(date +'%s')
((pciage = (now - pcitime) / 60))



pcitimeprev=$(cat pcifreezedate | awk '{print $1}' | tail -2 | head -1)
pcicurrent=$(cat pcifreezedate | awk '{print $1}' | tail -1)
#((pciage = (pcinow - pcitime) / 60))

pcihumantime=$(date -d '1970-01-01 '$pcitime' sec UTC')


echo "Latest available packages in LATEST since last PCI freeze on $pcihumantime" > package.lst
echo "#############################################" >> package.lst
find /data/FIXES/LATEST/rhel-x86_64-server-6/getPackage/ -name "*.rpm" -type f -mmin -$pciage -exec sh -c 'printf "%s %s \n" "$(ls -l $1)" "$(md5sum  $1)"' '' '{}' '{}' \; | awk '{$1=""; $2=""; $3="";  $4=""; $8="";  $9=""; print $0}' | awk -F'/' '{print $1 $7}' >> package.lst 

echo "Currently available packages in CURRENT_PCI between PCI freeze on $pcitimeprev and $pcicurrent" >> package.lst
echo "############################################" >> package.lst
find /data/FIXES/CURRENT_PCI/rhel-x86_64-server-6/getPackage/ -name "*.rpm" -type f -newermt $pcitimeprev ! -newermt $pcicurrent -exec sh -c 'printf "%s %s \n" "$(ls -l $1)" "$(md5sum  $1)"' '' '{}' '{}' \; | awk '{$1=""; $2=""; $3="";  $4=""; $8="";  $9=""; print $0}' | awk -F'/' '{print $1 $7}'  >> package.lst 



date --date="`cat freezedate | tail -1`" +%s > jbosstimeseconds

time=$(cat jbosstimeseconds)
now=$(date +'%s')
((age = (now - time) / 60))


timeprev=$(cat freezedate | awk '{print $1}' | tail -2 | head -1)
current=$(cat freezedate | awk '{print $1}' | tail -1)
#((currentage = (currentnow - timeprev) / 60))


humantime=$(date -d '1970-01-01 '$time' sec UTC')

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" >> package.lst
echo "Latest available packages in LATEST since last JBOSS freeze on $humantime" >> package.lst
echo "#############################################" >> package.lst
find /data/FIXES/LATEST/rhel-x86_64-server-6/getPackage/ -name "*.rpm" -type f -mmin -$age -exec sh -c 'printf "%s %s \n" "$(ls -l $1)" "$(md5sum  $1)"' '' '{}' '{}' \; | awk '{$1=""; $2=""; $3="";  $4=""; $8="";  $9=""; print $0}' | awk -F'/' '{print $1 $7}'  >> package.lst

echo "Currently available packages in CURRENT JBOSS between freeze on $timeprev and $current" >> package.lst
echo "############################################" >> package.lst
find /data/FIXES/CURRENT/rhel-x86_64-server-6/getPackage/ -name "*.rpm" -type f -newermt $timeprev ! -newermt $current -exec sh -c 'printf "%s %s \n" "$(ls -l $1)" "$(md5sum  $1)"' '' '{}' '{}' \; | awk '{$1=""; $2=""; $3="";  $4=""; $8="";  $9=""; print $0}' | awk -F'/' '{print $1 $7}'  >> package.lst


echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" >> package.lst
echo "!!!!!!!SPECIALLY FOR PASI 10 PACKAGES FOR PCI!!!!!!!!!!!!!!!!!!!" >> package.lst
cd /data/FIXES/CURRENT/rhel-x86_64-server-6/getPackage
ls -tr1 | tail -11 | head -10 | xargs md5sum >>/home/eldar/package.lst
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" >> /home/eldar/package.lst
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" >> /home/eldar/package.lst
echo "!!!!!!!SPECIALLY FOR PASI 10 PACKAGES FOR JBOSS!!!!!!!!!!!!!!!!!!!" >> /home/eldar/package.lst
cd /data/FIXES/CURRENT_PCI/rhel-x86_64-server-6/getPackage
ls -tr1 | tail -11 | head -10 | xargs md5sum >> /home/eldar/package.lst
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" >> /home/eldar/package.lst
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" >> /home/eldar/package.lst


chown eldar:group package.lst

