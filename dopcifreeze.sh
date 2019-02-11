#!/bin/bash

#For individual servers
connection_user=eldar
connection_pass=$(cat ./password | awk '{print $1}')
hostname=someserver1
#        echo "Please type the server name"
#        read hostname

./dopcifreeze.exp $connection_user $connection_pass $hostname


