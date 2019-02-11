#!/bin/bash
date --date="`cat pcifreezedate | tail -1`" +%s > pcitimeseconds
time=$(cat pcitimeseconds)
now=$(date +'%s')
((age = (now - time) / 60))


#pcitimeprev=$(cat pcifreezedate | awk '{print $1}' | tail -2 | head -1)
pcitimeprev=$(date -d"`rpm -qa --last | head -1 | awk '{print $2, $3, $4, $5, $6}'`" +%Y-%m-%d)
pcicurrent=$(cat pcifreezedate | awk '{print $1}' | tail -1)

#echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" > package.lst
#echo "Latest available packages in CURRENT since last MIRRORing for SUSE on $pcicurrent" >> package.lst
#echo "############################################" >> package.lst
#find /packages/\$RCE/SLES11-SP4-Updates/sle-11-i586/rpm/i586 -name "*.rpm" -type f -mmin -$age -exec sh -c 'printf "%s %s \n" "$(ls -l $1)" "$(md5sum  $1)"' '' '{}' '{}' \; | awk '{$1=""; $2=""; $3="";  $4=""; $8="";  $9=""; print $0}' | awk -F'/' '{print $1 $8}' >> package.lst

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" > package.lst
#echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" >> package.lst
echo "Latest available packages in CURRENT between $pcitimeprev and $pcicurrent FREEZE for SUSE" >> package.lst
echo "############################################" >> package.lst
find /packages/\$RCE/SLES11-SP4-Updates/sle-11-i586/rpm/i586 -name "*.rpm" -type f -newermt $pcitimeprev ! -newermt $pcicurrent -exec sh -c 'printf "%s %s \n" "$(ls -l $1)" "$(md5sum  $1)"' '' '{}' '{}' \; | awk '{$1=""; $2=""; $3="";  $4=""; $8="";  $9=""; print $0}' | awk -F'/' '{print $1 $8}' >> package.lst



chown eldar:group package.lst




#touch SLES_Repository_alphabethical_`date +%F`.out
#echo "PCI SLES REPO LIST IN ALPHABETICAL ORDER" > SLES_Repository_alphabethical_`date +%F`.out

#ls -l /packages/\$RCE/SLES11-SP4-Updates/sle-11-i586/rpm/i586 > test.txt
#awk  '{ print $9 }' test.txt  > test1.txt
#cat test1.txt | sort -f >> SLES_Repository_alphabethical_`date +%F`.out
##ls -l /packages/\$RCE/SLES11-SP4-Updates/sle-11-i586/rpm/i586 >> SLES_Repository_alphabethical_`date +%F`.out

#echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" >> SLES_Repository_alphabethical_`date +%F`.out


#echo "PCI SLES REPO LIST OF LATEST PACKAGES" >> SLES_Repository_alphabethical_`date +%F`.out

#ls -ltr /packages/\$RCE/SLES11-SP4-Updates/sle-11-i586/rpm/i586 >> SLES_Repository_alphabethical_`date +%F`.out


