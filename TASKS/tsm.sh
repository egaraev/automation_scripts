#!/bin/bash
cd /home/eldar
#Check is it Linux or AIX
if [ `uname -a | awk '{print $1}'` == Linux ]
then
echo "This is Linux"
dsmfile=/opt/tivoli/tsm/client/ba/bin/dsm.sys

today=`date '+%d.%m.%Y'`
yesterday=`date --date='yesterday' '+%d.%m.%Y'`
lastbackupdate=$(dsmc q fi | grep /home | awk '{print $2}')

if [ `echo $lastbackupdate | cut -d. -f3-` == `echo $today | cut -d. -f3-` ]
then	
lastbackup=$lastbackupdate
else
lastbackup=`date --date=$lastbackupdate '+%d.%m.%Y'`
fi



if [[ $lastbackup != $today ]] && [[ $lastbackup != $yesterday ]]
then 
echo "Backup was long time ago, needs to be checked"

#Check if process running or not
SERVICE=dsmc

if ps ax | grep -v grep | grep $SERVICE > /dev/null
then
    echo "$SERVICE service running"
        #Testing telnet
        port=`grep "^[^*;]" $dsmfile | grep ort | awk  '{print $2}' | head -1`
        address=`grep "^[^*;]" $dsmfile | grep ddress | awk  '{print $2}' | head -1`
        echo "Testing network connection to server"
        timeout 5 telnet $address $port
	echo "Checking incremental backup"
        nohup  dsmc i &
        timeout 30 tail -f nohup.out
	


	else
    	echo "There is no such $SERVICE service"
	if [ -f /etc/init.d/dsmc ]; then	
	chkconfig dsmc on
	echo "Adding service to autostart"
	else
	echo "There are no dsmc script file in /etc/init.d"
	fi
    	/etc/init.d/$SERVICE start
    	echo "$SERVICE starting"
    	sleep 10
        if [ `/etc/init.d/dsmc status | awk '{print $2}'` == dead ]
        then
                echo "Process cannot be started, checking error log"
                errorlog=`grep "^[^*;]" $dsmfile | grep error.log | awk '{print $2}' | head -1`
                tail -50 $errorlog
		sleep 10

        else
                echo "Process started, checking incremental backup"
        nohup  dsmc i & 
        timeout 30 tail -f nohup.out


        fi
fi

else
echo "We have new backup"
fi


else
echo "This is AIX"
dsmfile=/usr/tivoli/tsm/client/ba/bin64/dsm.sys


M=`date '+%m'`
Y=`date '+%y'`
D=`date '+%d'`
today=$M/$D/$Y
yesterday=$M/`expr $D - 1`/$Y


lastbackup=$(dsmc q fi | grep /home | awk '{print $2}')

if [[ $lastbackup != $today ]] && [[ $lastbackup != $yesterday ]]
then
echo "Backup was long time ago, needs to be checked"

#Check if process running or not
SERVICE=dsmc

if ps ax | grep -v grep | grep $SERVICE > /dev/null
then
    echo "$SERVICE service running"
        #Testing telnet
        port=`grep "^[^*;]" $dsmfile | grep ort | awk  '{print $2}' | head -1`
        address=`grep "^[^*;]" $dsmfile | grep  ddress | awk  '{print $2}' | head -1`
        echo "Testing network connection to server"

       #Port checking section start
                perl - $address $port  <<'__HERE__'
                use IO::Socket;
                # flush the print buffer immediately
                $| = 1;
                # Get command line parameters
                $target = shift ;
                $port = shift ;
                # Connect to host/port
                $socket = IO::Socket::INET->new(PeerAddr => $target , PeerPort => $port , Proto => 'tcp' , Timeout => 2);
                # Check connection
                if( $socket )
                {
                        #print "Port $port is open.\n" ;
                        $socket->close();
                        exit( 0 );
                }       
                else
                {
                #print "Port $port is closed or filtered.\n" ;
                exit( 1 );
                }
__HERE__
                if [ $? -eq 0 ]
                then
                echo "Telnet is working"
                else
                echo "Telnet is not working, please check network"
                fi
#End of port checking section


	echo "Checking incremental backup"
         dsmc i 


                echo "Checking error log"
                errorlog=`grep "^[^*;]" $dsmfile | grep dsmerror.log | awk '{print $2}' | head -1`
                tail -50 $errorlog

else
    echo "There is no such $SERVICE service"


	if [ -e /etc/init.d/dsmc ]
	then
    		/etc/init.d/$SERVICE start
	else
    	`cat /etc/inittab | grep -i dsm | awk {'print $1'} | cut -d: -f4-`
	fi

    	echo "$SERVICE starting"
    	sleep 10
        if [ `ps -ef | grep 'dsmc ' | tail -1 | awk {'print $10'}` == schedule ]
        then
                echo "Process started, checking incremental backup"
                           dsmc i 
        else
		echo "Process cannot be started, checking error log"
                errorlog=`grep "^[^*;]" $dsmfile | grep dsmerror.log | awk '{print $2}' | head -1`
                tail -50 $errorlog
                sleep 10

 
	fi
fi

else
echo "We have new backup"
fi


fi

