#!/bin/bash
systemctl stop NetworkManager
systemctl disable NetworkManager
sleep 2
systemctl stop firewalld
systemctl disable firewalld
sleep 2
sed -i s/enforcing/disabled/ /etc/selinux/config
sleep 3
systemctl stop irqbalance
systemctl disable irqbalance
sleep 3
tuned-adm profile latency-performance
sleep 3
systemctl stop chronyd
systemctl disable chronyd
sleep 3
yum install wget -y
yum install libcap-devel -y
sleep 1
rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sleep 2
yum install -y inotify-tools telnet lm_sensors openssl-devel tigervnc-server xinetd vim net-tools gcc pciutils msr-tools  glibc-devel.i686 libgcc.i686 bc mlocate tmux tcpdump iperf crash mcelog sar gcc-c++-4.8.5-36.el7.x86_64 htop ncdu
sleep 3
yum install libcap-devel -y
yum install python-pip -y
pip install --upgrade "pip < 21.0"
pip install pandas
pip install zmq
pip install inquirer
pip install  prettytable
pip install requests
pip install gspread
pip install blessings
pip3.6 install zmq
pip3.6 install  pandas
pip3.6 install inquirer
pip3.6 install  prettytable
pip3.6 install requests
pip3.6 install gspread
pip3.6 install blessings
#install mate
yum groupinstall "X Window system" "MATE Desktop" -y
yum remove mate-screensaver -y
