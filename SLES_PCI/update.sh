#!/bin/bash


#Removing evidence
rm -rf /home/eldar/evi*


if [ $? -eq 0 ]; then
    echo "Removed old evidences on `date` "
mkdir /home/eldar/evi_before; ifconfig -a >> /home/eldar/evi_before/ifconfig.txt;  mount >> /home/eldar/evi_before/mount.txt; ps -ef >> /home/eldar/evi_before/psef; ps aux >> /home/eldar/evi_before/psaux; df -h >> /home/eldar/evi_before/dfg; netstat -an >> /home/eldar/evi_before/netstatan; netstat -nr >> /home/eldar/evi_before/netstatnr; lsblk >> /home/eldar/evi_before/lsblk; route >> /home/eldar/evi_before/route; rpm -qa --queryformat "%-30{NAME}\t%{VERSION}-%{RELEASE}\t%{DISTRIBUTION}\t%{INSTALLTIME:date}\n" > /home/eldar/evi_before/`hostname`_BEFORE.txt; service --status-all >> /home/eldar/evi_before/services;
else
    echo "Unable to remove evidence on `hostname` , check manually"
fi



zypper ref -s
echo y | zypper up

if [ $? -eq 0 ]; then
    echo "Patching has been done successfully on  `date` "
else
    echo " check manually on `hostname`"
fi


if [ $? -eq 0 ]; then
    echo "Created new evidence on `date` "
mkdir /home/eldar/evi_after; ifconfig -a >> /home/eldar/evi_after/ifconfig.txt;  mount >> /home/eldar/evi_after/mount.txt; ps -ef >> /home/eldar/evi_after/psef; ps aux >> /home/eldar/evi_after/psaux; df -h >> /home/eldar/evi_after/dfg; netstat -an >> /home/eldar/evi_after/netstatan; netstat -nr >> /home/eldar/evi_after/netstatnr; lsblk >> /home/eldar/evi_after/lsblk; route >> /home/eldar/evi_after/route; rpm -qa --queryformat "%-30{NAME}\t%{VERSION}-%{RELEASE}\t%{DISTRIBUTION}\t%{INSTALLTIME:date}\n" > /home/eldar/evi_after/`hostname`_after.txt; service --status-all >> /home/eldar/evi_after/services;
else
    echo "Unable to take evidence on `hostname` , check manually"
fi


diff /home/eldar/evi_before/ifconfig.txt /home/eldar/evi_after/ifconfig.txt ; diff /home/eldar/evi_before/route /home/eldar/evi_after/route; diff /home/eldar/evi_before/lsblk /home/eldar/evi_after/lsblk; diff /home/eldar/evi_before/mount.txt /home/eldar/evi_after/mount.txt; diff /home/eldar/evi_before/services /home/eldar/evi_after/services;

rpm -qa --last |  head



sleep 10

