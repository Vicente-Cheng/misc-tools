#!/bin/bash -eux
# The script creates a QEMU image and attaches it to a Vagrant (libvirt) VM.
#
# What the script does:
# (1) It attaches a virtio-scsi controller to a domain if the domain doesn't have a controller yet.
# (2) Create a qcow2 file under $DISKS_DIR and attach it to the provided domain.
#
# Although we could not detect the next device automatically, now it is easy to use.
#
# Usage: ./attach-disk.sh <VM name> <Target device> <disk size (GB)>
#

TARGET_VM=$1
TARGET_DEVICE=$2
DISK_SIZE=$3
DISK_NAME=$TARGET_VM-$TARGET_DEVICE
DISKS_DIR=/tmp/libvirt_disks

# create disk image
mkdir -p $DISKS_DIR
FILE=$DISKS_DIR/$DISK_NAME.qcow2
qemu-img create -f qcow2 $FILE "${DISK_SIZE}"g


CONTROLLER_XML=controller.xml
cat > $CONTROLLER_XML << EOF
    <controller type='scsi' model='virtio-scsi' index='0'/>
EOF

# attach virtio-scsi controller, it's more robust for hotplugging
if ! virsh dumpxml $TARGET_VM | grep -q 'virtio-scsi'; then
  echo "Attach virtio-scsi controller to $TARGET_VM"
  virsh attach-device --domain $TARGET_VM --file $CONTROLLER_XML --live
fi

# attach device
XML_FILE=$DISKS_DIR/$DISK_NAME.xml
cat > $XML_FILE <<EOF
    <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2'/>
      <source file='$FILE'/>
      <target dev='$TARGET_DEVICE' bus='scsi'/>
      <wwn>0x5000c50015$(date +%s | sha512sum | head -c 6)</wwn>
    </disk>
EOF

virsh attach-device --domain $TARGET_VM --file $XML_FILE --live
