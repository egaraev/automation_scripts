#!/bin/bash
before=$(rpm -qa --last | head -1)


#echo y | yum install wireshark 




after=$(rpm -qa --last | head -1)

if [ "$before" == "$after" ]
then
echo "Update failed, please see logs"
else
echo "Reboot is started"
fi

