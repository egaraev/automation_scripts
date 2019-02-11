#!/bin/bash
touch SLES_Repository_alphabethical_`date +%F`.out
echo "PCI SLES REPO LIST IN ALPHABETICAL ORDER" > SLES_Repository_alphabethical_`date +%F`.out

ls -l /packages/\$RCE/SLES11-SP4-Updates/sle-11-i586/rpm/i586 > test.txt
awk  '{ print $9 }' test.txt  > test1.txt
cat test1.txt | sort -f >> SLES_Repository_alphabethical_`date +%F`.out
#ls -l /packages/\$RCE/SLES11-SP4-Updates/sle-11-i586/rpm/i586 >> SLES_Repository_alphabethical_`date +%F`.out

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" >> SLES_Repository_alphabethical_`date +%F`.out


echo "PCI SLES REPO LIST OF LATEST PACKAGES" >> SLES_Repository_alphabethical_`date +%F`.out

ls -ltr /packages/\$RCE/SLES11-SP4-Updates/sle-11-i586/rpm/i586 >> SLES_Repository_alphabethical_`date +%F`.out


