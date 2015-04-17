#!/bin/sh

echo $1
echo $2
echo $3

host=$1
device=$2
osd_num=$3

sudo mkdir -p /var/lib/ceph/osd/ceph-$osd_num
ceph osd crush add osd.$osd_num 1 root=default host=$host
sudo /sbin/sgdisk --zap-all $device
sudo /sbin/sgdisk --largest-new=1 --change-name=1:"ceph kv-data" --typecode=1:4fbd7e29-9d25-41b8-afd0-062c0ceff05d --mbrtogpt -- $device
sudo mkfs -t xfs -f -i size=2048 ${device}1
sudo mount ${device}1 -t xfs -o rw,noatime,inode64,logbsize=256k,delaylog,allocsize=4M /var/lib/ceph/osd/ceph-$osd_num
sudo ceph-osd --id $osd_num -d --mkkey --mkfs --osd-data /var/lib/ceph/osd/ceph-$osd_num
sudo ceph auth add osd.$osd_num osd 'allow *' mon 'allow profile osd' -i /var/lib/ceph/osd/ceph-$osd_num/keyring
sudo start ceph-osd id=$osd_num
