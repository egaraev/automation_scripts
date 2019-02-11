#!/bin/bash
before=$(rpm -qa --last | head -1)

cd /etc
sed -i.bak '/exclude/d' ./yum.conf

nodestate=$(clustat | grep Cluster | awk {'print $1'})
if [ "Cluster" = "$nodestate" ];
then
echo "We have cluster here"
#echo "Check if it is passive node"
noderole=$(clustat |grep service |awk {'print $2'})
nodename=$(hostname)


       if [ "$nodename" != "$noderole" ] && [ "$(date +%Y-%m-%d)" !=  "$(cat /home/eldar/patchtimestamp | awk '{print $1}')" ]; then
              echo "This is passive node, starting updating"  
              echo `date +%Y-%m-%d` > /home/eldar/patchtimestamp


                        if [ $? -eq 0 ]; then
                    echo "Created BEFORE evidences on `date` "
                        rm -rf /home/eldar/evi*
                        mkdir /home/eldar/evi_before; ifconfig -a >> /home/eldar/evi_before/ifconfig.txt;  mount >> /home/eldar/evi_before/mount.txt; ps -ef >> /home/eldar/evi_before/psef; ps aux >> /home/eldar/evi_before/psaux; df -h >> /home/eldar/evi_before/dfg; netstat -an >> /home/eldar/evi_before/netstatan; netstat -nr >> /home/eldar/evi_before/netstatnr; lsblk >> /home/eldar/evi_before/lsblk; route >> /home/eldar/evi_before/route; rpm -qa --queryformat "%-30{NAME}\t%{VERSION}-%{RELEASE}\t%{DISTRIBUTION}\t%{INSTALLTIME:date}\n" > /home/eldar/evi_before/`hostname`_BEFORE.txt; service --status-all >> /home/eldar/evi_before/services;
                        else
                         echo "Unable to create BEFORE evidence on `hostname` , check manually"
                        fi


		#Stop cluster services on passive node
		service rgmanager stop
		service ricci stop 
		service luci stop 
		service cman stop

		#### PASSIVE PATCHING CODE HERE
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
			after=$(rpm -qa --last | head -1)

			if [ "$before" == "$after" ]
			then
			echo "Update failed, please see logs"
			else
			echo "Reboot is started , you can cancel it during 10 seconds"
			fi

			sleep 10 
			reboot


		
	
		#### PASSIVE PATCHING CODE HERE FINISHED


              echo "Passive node patched, exiting"            
              exit
        elif [ "$(date +%Y-%m-%d)" =  "$(cat /home/eldar/patchtimestamp | awk '{print $1}')"  ]; then
                echo "This node already patched today"
                exit
       fi

echo "This is an active node"
		rgstatus=$(grep "`date +"%b %d"`" /var/log/cluster/rgmanager.log | grep "rgmanager State change:" | awk {'print $8'})
                      if [ "$rgstatus" = "UP" ]; 
                       then
                               echo "Starting to patch active node"    
                                echo `date +%Y-%m-%d` > /home/eldar/patchtimestamp

rm -rf /home/eldar/evi*
                                                        if [ $? -eq 0 ]; then
                                    echo "Created BEFORE evidences on `date` "
                                mkdir /home/eldar/evi_before; ifconfig -a >> /home/eldar/evi_before/ifconfig.txt;  mount >> /home/eldar/evi_before/mount.txt; ps -ef >> /home/eldar/evi_before/psef; ps aux >> /home/eldar/evi_before/psaux; df -h >> /home/eldar/evi_before/dfg; netstat -an >> /home/eldar/evi_before/netstatan; netstat -nr >> /home/eldar/evi_before/netstatnr; lsblk >> /home/eldar/evi_before/lsblk; route >> /home/eldar/evi_before/route; rpm -qa --queryformat "%-30{NAME}\t%{VERSION}-%{RELEASE}\t%{DISTRIBUTION}\t%{INSTALLTIME:date}\n" > /home/eldar/evi_before/`hostname`_BEFORE.txt; service --status-all >> /home/eldar/evi_before/services;
                                        else
                                            echo "Unable to create BEFORE evidence on `hostname` , check manually"
                                        fi


                               echo "Moving resource group to passive node"
                                #Moving RG to passive node				
                               RG=$(clustat |grep service | awk {'print $1'} | sed "s/[^:]*://")
                                clusvcadm -r $RG
				service rgmanager stop
				service ricci stop 
				service luci stop 
				service cman stop	

                                #### ACTIVE NODE PATCHING CODE HERE
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
				echo "Reboot is started, you can cancel it during 10 seconds"
				fi

				sleep 10
				reboot


				echo "Active node patched"
                                #### ACTIVE NODE  PATCHING CODE HERE FINISHED
                               exit
                       else
                               echo "This is active node, but passive node should be patched first, exiting"
                               exit
                       fi

else
#### STANDALONE PATCHING CODE HERE
rm -rf /home/eldar/evi*
if [ $? -eq 0 ]; then
    echo "Created BEFORE evidences on `date` "
mkdir /home/eldar/evi_before; ifconfig -a >> /home/eldar/evi_before/ifconfig.txt;  mount >> /home/eldar/evi_before/mount.txt; ps -ef >> /home/eldar/evi_before/psef; ps aux >> /home/eldar/evi_before/psaux; df -h >> /home/eldar/evi_before/dfg; netstat -an >> /home/eldar/evi_before/netstatan; netstat -nr >> /home/eldar/evi_before/netstatnr; lsblk >> /home/eldar/evi_before/lsblk; route >> /home/eldar/evi_before/route; rpm -qa --queryformat "%-30{NAME}\t%{VERSION}-%{RELEASE}\t%{DISTRIBUTION}\t%{INSTALLTIME:date}\n" > /home/eldar/evi_before/`hostname`_BEFORE.txt; service --status-all >> /home/eldar/evi_before/services;
else
    echo "Unable to create BEFORE evidence on `hostname` , check manually"
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

after=$(rpm -qa --last | head -1)

if [ "$before" == "$after" ]
then
echo "Update failed, please see logs"
else
echo "Reboot is started , you can cancel it during 10 seconds"
fi
sleep 10
reboot

echo "Standalone server patched"
#### STANDALONE PATCHING CODE HERE FINISHED
fi


