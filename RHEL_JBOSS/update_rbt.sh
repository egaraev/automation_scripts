#!/bin/bash
before=$(rpm -qa --last | head -1)

#if [ -e /etc/redhat-release ]
#then
#    echo "This is Red Hat system, editing yum.conf"
cd /etc
sed -i.bak '/exclude/d' ./yum.conf

#else
#    echo "This is SUSE system"
#fi

rm -rf /home/eldar/evi*
if [ $? -eq 0 ]; then
    echo "Created BEFORE evidences on `date` "
mkdir /home/eldar/evi_before; ifconfig -a >> /home/eldar/evi_before/ifconfig.txt;  mount >> /home/eldar/evi_before/mount.txt; ps -ef >> /home/eldar/evi_before/psef; ps aux >> /home/eldar/evi_before/psaux; df -h >> /home/eldar/evi_before/dfg; netstat -an >> /home/eldar/evi_before/netstatan; netstat -nr >> /home/eldar/evi_before/netstatnr; lsblk >> /home/eldar/evi_before/lsblk; route >> /home/eldar/evi_before/route; rpm -qa --queryformat "%-30{NAME}\t%{VERSION}-%{RELEASE}\t%{DISTRIBUTION}\t%{INSTALLTIME:date}\n" > /home/eldar/evi_before/`hostname`_BEFORE.txt; service --status-all >> /home/eldar/evi_before/services;
else
    echo "Unable to create BEFORE evidence on `hostname` , check manually"
fi







SERVICE1='vepa-mobile-app'
 
if ps ax | grep -v grep | grep $SERVICE1 > /dev/null
then
    echo "$SERVICE1 service running, "
    echo "Stopping  $SERVICE1 before patching"
   /etc/init.d/$SERVICE1 stop
else
    echo there is no such "$SERVICE1 service"
fi

SERVICE2='net-bank-app'
 
if ps ax | grep -v grep | grep $SERVICE2 > /dev/null
then
    echo "$SERVICE2 service running, "
    echo "Stopping  $SERVICE2 before patching"
    /etc/init.d/$SERVICE2 stop
else
    echo there is no such "$SERVICE2 service"
fi

SERVICE3='jboss-as-7'

if ps ax | grep -v grep | grep $SERVICE3 > /dev/null
then
    echo "$SERVICE3 service running, "
    echo "Stopping  $SERVICE3 before patching"
    /etc/init.d/$SERVICE3 stop
else
    echo there is no such "$SERVICE3 service"
fi

SERVICE4='stp-xdss'

if ps ax | grep -v grep | grep $SERVICE4 > /dev/null
then
    echo "$SERVICE4 service running, "
    echo "Stopping  $SERVICE4 before patching"
    /etc/init.d/$SERVICE4 stop
else
    echo there is no such "$SERVICE4 service"
fi

SERVICE5='stp-app'

if ps ax | grep -v grep | grep $SERVICE5 > /dev/null
then
    echo "$SERVICE5 service running, "
    echo "Stopping  $SERVICE5 before patching"
    /etc/init.d/$SERVICE5 stop
else
    echo there is no such "$SERVICE5 service"
fi


SERVICE6='rabbitmq-server'

if ps ax | grep -v grep | grep $SERVICE6> /dev/null
then
    echo "$SERVICE6 service running, "
    echo "Stopping  $SERVICE6 before patching"
    service $SERVICE6 stop
else
    echo there is no such "$SERVICE6 service"
fi

SERVICE7='db2'

if ps ax | grep -v grep | grep $SERVICE7> /dev/null
then
    echo "$SERVICE7 service running, "
    echo "Stopping  $SERVICE7 before patching"
	su - blinstt
	db2 deactivate db ablidb22
	db2 terminate
	db2stop
	logout
else
    echo there is no such "$SERVICE7 service"
fi


SERVICE8='ceph'

if ps ax | grep -v grep | grep $SERVICE8> /dev/null
then
    echo "$SERVICE8 service running, "
    echo "Stopping  $SERVICE8 before patching"
    service $SERVICE8 stop
else
    echo there is no such "$SERVICE8 service"
fi



SERVICE9='httpd'

if ps ax | grep -v grep | grep $SERVICE9> /dev/null
then
    echo "$SERVICE9 service running, "
    echo "Stopping  $SERVICE9 before patching"
    service $SERVICE9 stop
else
    echo there is no such "$SERVICE9 service"
fi



SERVICE10='integration-agent'

if ps ax | grep -v grep | grep $SERVICE10> /dev/null
then
    echo "$SERVICE10 service running, "
    echo "Stopping  $SERVICE10 before patching"
    service $SERVICE10 stop
else
    echo there is no such "$SERVICE10 service"
fi


SERVICE11='integration-hub'

if ps ax | grep -v grep | grep $SERVICE11> /dev/null
then
    echo "$SERVICE11 service running, "
    echo "Stopping  $SERVICE11 before patching"
	service $SERVICE11 stop
else
    echo there is no such "$SERVICE11 service"
fi



SERVICE12='shibd'

if ps ax | grep -v grep | grep $SERVICE12> /dev/null
then
    echo "$SERVICE12 service running, "
    echo "Stopping  $SERVICE12 before patching"
	service $SERVICE12 stop
else
    echo there is no such "$SERVICE12 service"
fi



SERVICE13='tenants'

if ps ax | grep -v grep | grep $SERVICE13> /dev/null
then
    echo "$SERVICE13 service running, "
    echo "Stopping  $SERVICE13 before patching"
    service $SERVICE13 stop
else
    echo there is no such "$SERVICE13 service"
fi



SERVICE14='tomcat6'

if ps ax | grep -v grep | grep $SERVICE14> /dev/null
then
    echo "$SERVICE14 service running, "
    echo "Stopping  $SERVICE14 before patching"
    service $SERVICE14 stop
else
    echo there is no such "$SERVICE14 service"
fi



SERVICE15='webshop'

if ps ax | grep -v grep | grep $SERVICE15> /dev/null
then
    echo "$SERVICE15 service running, "
    echo "Stopping  $SERVICE15 before patching"
	service $SERVICE15 stop
else
    echo there is no such "$SERVICE15 service"
fi




SERVICE16='idp'

if ps ax | grep -v grep | grep $SERVICE16> /dev/null
then
    echo "$SERVICE16 service running, "
    echo "Stopping  $SERVICE16 before patching"
    service $SERVICE16 stop
else
    echo there is no such "$SERVICE16 service"
fi   







echo "Starting patching script"
echo y | /usr/local/bin/UPDATE -update-all
if [ $? -eq 0 ]; then
    echo "Patching has been done successfully on  `date` "
else
    echo " Check manually on `hostname`"
fi


echo "Creating new AFTER evidence on `date` "
mkdir /home/eldar/evi_after; ifconfig -a >> /home/eldar/evi_after/ifconfig.txt;  mount >> /home/eldar/evi_after/mount.txt; ps -ef >> /home/eldar/evi_after/psef; ps aux >> /home/eldar/evi_after/psaux; df -h >> /home/eldar/evi_after/dfg; netstat -an >> /home/eldar/evi_after/netstatan; netstat -nr >> /home/eldar/evi_after/netstatnr; lsblk >> /home/eldar/evi_after/lsblk; route >> /home/eldar/evi_after/route; rpm -qa --queryformat "%-30{NAME}\t%{VERSION}-%{RELEASE}\t%{DISTRIBUTION}\t%{INSTALLTIME:date}\n" > /home/eldar/evi_after/`hostname`_after.txt; service --status-all >> /home/eldar/evi_after/services;
if [ $? -eq 0 ]; then
echo "Created new AFTER evidence on `date` "
else
    echo "Unable to take AFTER evidence on `hostname` , check manually"
fi


diff /home/eldar/evi_before/ifconfig.txt /home/eldar/evi_after/ifconfig.txt ; diff /home/eldar/evi_before/route /home/eldar/evi_after/route; diff /home/eldar/evi_before/lsblk /home/eldar/evi_after/lsblk; diff /home/eldar/evi_before/mount.txt /home/eldar/evi_after/mount.txt; diff /home/eldar/evi_before/services /home/eldar/evi_after/services;

rpm -qa --last |  head


sleep 5


after=$(rpm -qa --last | head -1)

if [ "$before" == "$after" ]
then
echo "Update failed, please see logs"
else
echo "Reboot is started , you can cancel it during 10 seconds"
sleep 10
reboot
fi




