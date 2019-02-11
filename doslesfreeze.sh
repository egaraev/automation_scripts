#!/bin/bash

#For individual servers
connection_user=eldar
connection_pass=$(cat ./password | awk '{print $1}')
hostname=someserver
#        echo "Please type the server name"
#        read hostname

./doslesfreeze.exp $connection_user $connection_pass $hostname


