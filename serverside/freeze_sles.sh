smt-repos -m -e SLES11-SP4-Updates sle-11-i586
smt-repos -m -e SLE11-SDK-SP4-Pool sle-11-x86_64
smt-repos -m -e SLE11-SDK-SP4-Pool sle-11-i586
smt-repos -m -e SLE11-SDK-SP4-Updates sle-11-x86_64
smt-repos -m -e SLE11-SDK-SP4-Updates sle-11-i586
smt-repos -m -e SLES11-SP4-Pool sle-11-i586
smt-repos -m -e SLES11-SP4-Pool sle-11-x86_64
smt-repos -m -e SLES11-SP4-Updates sle-11-x86_64
smt-repos -m -e SLES11-SP4-Updates sle-11-i586
smt-mirror

smt-repos -m -d SLES11-SP4-Updates sle-11-i586
smt-repos -m -d SLES11-SP4-Updates sle-11-i586
smt-repos -m -d SLE11-SDK-SP4-Pool sle-11-x86_64
smt-repos -m -d SLE11-SDK-SP4-Pool sle-11-i586
smt-repos -m -d SLE11-SDK-SP4-Updates sle-11-x86_64
smt-repos -m -d SLE11-SDK-SP4-Updates sle-11-i586
smt-repos -m -d SLES11-SP4-Pool sle-11-i586
smt-repos -m -d SLES11-SP4-Pool sle-11-x86_64
smt-repos -m -d SLES11-SP4-Updates sle-11-x86_64

echo `date +'%Y-%m-%d %H:%M'` >> /home/eldar/pcifreezedate

