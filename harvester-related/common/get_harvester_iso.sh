#!/bin/bash
#
# Usage: ./get_harvester_iso.sh <version>

if [[ $# != 1 ]]
then
        echo "Usage: ./get_harvester_iso.sh <version>"
        exit 0
fi
VERSION=$1

wget https://releases.rancher.com/harvester/$VERSION/harvester-$VERSION-amd64.iso &
wget https://releases.rancher.com/harvester/$VERSION/harvester-$VERSION-amd64.sha512 &
wget https://releases.rancher.com/harvester/$VERSION/harvester-$VERSION-initrd-amd64 &
wget https://releases.rancher.com/harvester/$VERSION/harvester-$VERSION-vmlinuz-amd64 &
wget https://releases.rancher.com/harvester/$VERSION/harvester-$VERSION-rootfs-amd64.squashfs &
