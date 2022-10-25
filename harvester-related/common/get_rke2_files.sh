#!/bin/bash
#
# Usage: ./get_rke2_files.sh <version>

if [[ $# != 1 ]]
then
        echo "Usage: ./get_rke2_files.sh <version>"
        exit 0
fi
RKE2_VERSION=$1

wget https://github.com/rancher/rke2/releases/download/${RKE2_VERSION}/rke2-images-harvester.linux-amd64.tar.zst &
wget https://github.com/rancher/rke2/releases/download/${RKE2_VERSION}/rke2-images-harvester.linux-amd64.txt &
wget https://github.com/rancher/rke2/releases/download/${RKE2_VERSION}/rke2-images-multus.linux-amd64.txt &
wget https://github.com/rancher/rke2/releases/download/${RKE2_VERSION}/rke2-images.linux-amd64.tar.zst &
wget https://github.com/rancher/rke2/releases/download/${RKE2_VERSION}/rke2-images.linux-amd64.txt &
