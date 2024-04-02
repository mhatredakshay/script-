#!/usr/bin/bash

echo -e "[cdrom]\nname=cdrom\nbaseurl=file:///mnt\nenabled=1\ngpgcheck=0" >> /etc/yum.repos.d/cdrom.repo
yum clean all
yum repolist
