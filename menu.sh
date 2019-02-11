#!/bin/bash
#==============================================================================

#Menu options
options[0]="Restart agents on a few servers"
options[1]="Upload file"
options[2]="Download file"
options[3]="Upload bash script, run it and download results/errors"
options[4]="Run specific command"
options[5]="Run specific ROOT command"
options[6]="Do Freeze for RHEL"
options[7]="Get information about packages"
options[8]="Update PCI SLES with restart"
options[9]="Update PCI SLES without restart"
options[10]="Update RHEL without restart"
options[11]="Update RHEL with restart"
options[12]="Get the list of installed RPMs and APARs list"
options[14]="Do freeze for SLES"
options[15]="Check if host restarted"
options[16]="Check TSM failures"
options[18]="Fix mail problems"
options[19]="Check SWAP usage on AIX"
options[20]="Check ntp"
options[21]="Clean SCM agent folder"


#Actions to take based on selection
function ACTIONS {
    if [[ ${choices[0]} ]]; then
        #Option 1 selected
        #echo "Option 1 selected"
	agent=1
	./add_hosts.sh $agent
    fi
    if [[ ${choices[1]} ]]; then
        #Option 2 selected
        echo "Upload the file"
	agent=2
#	echo "Please specify local filename" 
#	read localfilename
#	echo "Please specify remote filename "
#	read remotefilename
        ./add_hosts.sh $agent $localfilename $remotefilename


    fi
    if [[ ${choices[2]} ]]; then
        #Option 3 selected
        echo "Download the file"
        agent=3
#        echo "Please specify local filename" 
#        read localfilename
#        echo "Please specify remote filename"
#        read remotefilename
        ./add_hosts.sh $agent $localfilename $remotefilename
    fi
    if [[ ${choices[3]} ]]; then
        #Option 4 selected
        #echo ""
	agent=4
	echo "Upload bash script, run it and download results/errors"
	echo "Please insert needed commands to /home/eldar/script/RUN_SCRIPT/myscript.sh"
	./add_hosts.sh $agent	
    fi
    if [[ ${choices[10]} ]]; then
        #Option 10 selected
        echo "Updating the PCI RHEL without restart"
	agent=5
        ./add_hosts.sh $agent
    fi
    if [[ ${choices[7]} ]]; then
        #Option 7 selected
        echo "Getting information about the packages"
        ./getpackages.sh
    fi
    if [[ ${choices[6]} ]]; then
        #Option 6 selected
        echo "Doing the freeze"
        ./dofreeze.sh
    fi
    if [[ ${choices[5]} ]]; then
        #Option 5 selected
	agent=6
        echo "Run ROOT  command on the servers"
        ./add_hosts.sh $agent
    fi
    if [[ ${choices[12]} ]]; then
        #Option 12 selected
	agent=7
        echo "Get the list of installed RPMs"
        ./add_hosts.sh $agent
    fi

    if [[ ${choices[9]} ]]; then
        #Option 9 selected
        agent=8
        echo "Update the PCI SLES without restart"
        ./add_hosts.sh $agent
    fi
    if [[ ${choices[4]} ]]; then
        #Option 4 selected
        agent=9
        echo "Run non-root command"
        ./add_hosts.sh $agent
    fi

    if [[ ${choices[11]} ]]; then
        #Option 11 selected
        agent=10
        echo "Update RHEL with restart"
        ./add_hosts.sh $agent
    fi
    if [[ ${choices[8]} ]]; then
        #Option 8 selected
        agent=11
        echo "Update PCI SLES with restart"
        ./add_hosts.sh $agent
    fi


 if [[ ${choices[14]} ]]; then
        #Option 14 selected
        echo "Doing the SLES freeze"
        ./doslesfreeze.sh
    fi

    if [[ ${choices[15]} ]]; then
        #Option 15 selected
        echo "Checking servers for restart"
        ./testconn.sh
    fi

   if [[ ${choices[16]} ]]; then
        #Option 16 selected
	agent=12
        echo "Checking servers for TSM Agent"
        ./add_hosts.sh $agent
    fi



if [[ ${choices[18]} ]]; then
        #Option 18 selected
        agent=13
        echo "Fix mail problem"
        ./add_hosts.sh $agent
    fi

if [[ ${choices[19]} ]]; then
        #Option 19 selected
        agent=14
        echo "Check SWAP usage"
        ./add_hosts.sh $agent
    fi


if [[ ${choices[20]} ]]; then
        #Option 20 selected
        agent=15
        echo "Check NTP log"
        ./add_hosts.sh $agent
    fi


if [[ ${choices[21]} ]]; then
        #Option 21 selected
        agent=16
        echo "Clean SCM agent"
        ./add_hosts.sh $agent
    fi



}

#Variables
ERROR=" "

#Clear screen for menu
clear

#Menu function
function MENU {
    echo "Menu Options"
    for NUM in ${!options[@]}; do
        echo "[""${choices[NUM]:- }""]" $(( NUM+1 ))") ${options[NUM]}"
    done
    echo "$ERROR"
}

#Menu loop
while MENU && read -e -p "Select the desired options using their number (again to uncheck, ENTER when done): " -n2 SELECTION && [[ -n "$SELECTION" ]]; do
    clear
    if [[ "$SELECTION" == *[[:digit:]]* && $SELECTION -ge 1 && $SELECTION -le ${#options[@]} ]]; then
        (( SELECTION-- ))
        if [[ "${choices[SELECTION]}" == "+" ]]; then
            choices[SELECTION]=""
        else
            choices[SELECTION]="+"
        fi
            ERROR=" "
    else
        ERROR="Invalid option: $SELECTION"
    fi
done

ACTIONS
