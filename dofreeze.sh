#!/bin/bash
echo "IS IT PCI THEN PRESS y "
read answerpci


if [ "$answerpci" = "y" ] || [ "$answerpci" = "yes" ] || [ "$answerpci" = "Y" ] || [ "$answerpci" = "YES" ]
then
	./dopcifreeze.sh
else
	./dojbossfreeze.sh
fi


