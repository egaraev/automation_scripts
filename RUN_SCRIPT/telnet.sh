#!/bin/bash

 timeout 5 telnet 127.0.0.1 23 &
                if [ $? -eq 0 ]; then
                echo "Telnet is working"
                else
                echo "Telnet is not working, please check FW"
                fi




