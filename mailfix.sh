#!/bin/bash
echo "IF IT IS LINUX THEN PRESS y "
read answer


if [ "$answer" = "y" ] || [ "$answer" = "yes" ] || [ "$answer" = "Y" ] || [ "$answer" = "YES" ]
then
	./maillinux.sh
else
	./mailaix.sh
fi


