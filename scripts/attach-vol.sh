#!/bin/bash
# used by attach volume to running VM

if [ "$#" -ne 3 ]; then
        echo "Usage: attach-vol.sh <Vol Name> <VM Name> <Target Device>"
fi

volName=$1
VMName=$2
targetDevice=$3

LIBVIRTPATH="/var/lib/libvirt"
volPath="$LIBVIRTPATH/$1"

wwnString=$(md5sum ${volPath} |awk {'print $1'} |head -c 16)
echo "Try to attach volume ${volName} to VM ${VMName} target: ${targetDevice}, wwn: ${wwnString}"

virsh attach-disk ${VMName} --source ${volPath} --target ${targetDevice} --wwn ${wwnString} --persistent
