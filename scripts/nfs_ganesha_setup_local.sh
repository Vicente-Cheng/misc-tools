#!/bin/bash

# run this script on `nfs-ganesha` folder
echo "Setup local dbus systemd related config"
cp src/scripts/ganeshactl/org.ganesha.nfsd.conf /etc/dbus-1/system.d/nfs-ganesha-dbus.conf
cp src/scripts/systemd/sysconfig/nfs-ganesha /etc/default/nfs-ganesha
cp src/scripts/systemd/nfs-ganesha.service.debian8 /usr/lib/systemd/system/nfs-ganesha.service
cp src/scripts/systemd/nfs-ganesha-lock.service.debian8 /usr/lib/systemd/system/nfs-ganesha-lock.service
cp src/scripts/systemd/nfs-ganesha-config.service /usr/lib/systemd/system/nfs-ganesha-config.service
cp src/scripts/nfs-ganesha-config.sh /usr/libexec/ganesha/nfs-ganesha-config.sh
chmod a+x /usr/libexec/ganesha/nfs-ganesha-config.sh
echo "Setup successfully."
