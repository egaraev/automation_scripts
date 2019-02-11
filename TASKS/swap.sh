#!/usr/bin/bash
echo "### COMMENTS ###"
echo "Investigated possible High usage of IO Paging Space."
echo "Temporary SWAP peak that is already over"
echo
echo "### SERVER AND DATE ###"
uname -a; date;
echo
echo "### VMSTAT 1 6 OUTPUT ###"
vmstat 1 6
echo
echo "### CHECKING SWAP UTILISATION ###"
lsps -s
echo
echo "TOP 3 Swap consumers:"
totalswp=$(lsps -s | tail -1 | awk '{ print $1}' | cut -d'M' -f1)
# echo "Total SWAP space is $(tput bold)$totalswp$(tput sgr0)."
for line in $(svmon -U -g -t 3 | egrep -p "User" | grep -v "=" | grep -v User | grep -e "[0-9]" | grep '^[A-z]' | tr [" "] ["$"])
do
line=$(echo $line | tr ["$"] [" "])
user=$(echo $line | awk '{ print $1 }')
swpuse=$(echo $line | awk '{ print $4}')
swpmb=$(echo $swpuse*4/1024 | bc)
swpperc=$(echo $swpmb $totalswp | awk '{print ($1 / $2 ) * 100 }' | awk '{print substr($0,0,4)}')
echo "User $(tput bold)$user $(tput sgr0) is consuming $swpmb MB. ($swpperc % of the Total)"
done
echo "Top 10 PAGING consumers"
ps avwx | head -1; ps avwx | sort +4n -r | head -10

