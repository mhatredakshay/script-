#!/bin/bash
systemctl stop sfptpd 
sleep 3 
/usr/sbin/onload_tool reload

sleep 2 
/usr/sbin/ifdown eth2
/usr/sbin/ifup eth2
sleep 2 
/usr/sbin/ifdown eth3
/usr/sbin/ifup eth3


sleep 3 
/usr/sbin/ethtool -G eth2 rx 4096 tx 2048
/usr/sbin/ethtool -G eth3 rx 4096 tx 2048

sleep 5
systemctl start sfptpd
sleep 5
tee /var/log/sfptpd_err.log < /dev/null
tee /var/log/sfptpd_stats.log < /dev/null

#python /home/irage/prod/scripts/assign_irq.py eth0 eth1 eth2
sleep 5
ls -1 /proc/irq/|grep -v default > /tmp/irq_temp.txt
while read -r line
do
#cat /proc/irq/$line/smp_affinity_list > /tmp/$line.txt
echo 0 > /proc/irq/$line/smp_affinity_list
echo $line
done</tmp/irq_temp.txt
rm -f /tmp/irq_temp.txt

#Settings for intel-cat
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/intel-cat/
./intel-cat/allocation_app 0 0x7f8
./intel-cat/allocation_app 1 0x7
./intel-cat/association_app 1 0 13 14 15 

