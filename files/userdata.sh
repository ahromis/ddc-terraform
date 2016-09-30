#!/bin/bash

apt-get update
apt-get upgrade -y
apt-get install -y awscli

# Grab instance ID and region as the 'describe-tags' action below requires them. Getting the region
# is a pain (see http://stackoverflow.com/questions/4249488/find-region-from-within-ec2-instance)
INSTANCE_ID=$(ec2metadata --instance-id)
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')

# Grab tag value
KEY=Name
NAME=$(aws ec2 describe-tags --filters "Name=resource-id,Values=${INSTANCE_ID}" "Name=key,Values=${KEY}" --region=${REGION} --output=text | cut -f5)

if [[ "${HOSTNAME}" != "${NAME%%.*}" ]]; then
  echo "${NAME}" > /etc/hostname
  hostname "${NAME}"
  sed -i "/127.0.0.1.*/a 127.0.1.1 ${NAME}" /etc/hosts
  echo "Fixed Hostname"
else
  echo "Hostname ok"
fi

MOUNT_POINT=/var/lib/docker
mkdir -p ${MOUNT_POINT}
mkfs -t ext4 /dev/xvdb
mount /dev/xvdb ${MOUNT_POINT}
echo "/dev/xvdb ${MOUNT_POINT} ext4 defaults,nofail 0 2" >> /etc/fstab
