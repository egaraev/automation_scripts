#!/bin/bash
touch RHEL_Repository_alphabethical_`date +%F`.out

echo "PCI REPO RHEL LIST OF LATEST PACKAGES" > RHEL_Repository_alphabethical_`date +%F`.out


ls /data/FIXES/LATEST/rhel-x86_64-server-6/getPackage >> RHEL_Repository_alphabethical_`date +%F`.out
sed -i.bak '/389/d' ./RHEL_Repository_alphabethical_`date +%F`.out
ls /data/FIXES/LATEST/rhel-x86_64-server-6/getPackage | grep 389 >> RHEL_Repository_alphabethical_`date +%F`.out


echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" >> RHEL_Repository_alphabethical_`date +%F`.out

echo "PCI REPO RHEL LIST OF LATEST PACKAGES" >> RHEL_Repository_alphabethical_`date +%F`.out
ls -ltr /data/FIXES/LATEST/rhel-x86_64-server-6/getPackage/ | awk '{print $6, $7, $8, $9}' >> RHEL_Repository_alphabethical_`date +%F`.out


