#!/bin/bash
str=$(file -s /dev/xvdh | grep "/dev/xvdh: data")
if [ ! "$str" = "" ]; then
  mkfs -t ext4 /dev/xvdh
fi
mount /dev/xvdh /srv/backend/shared/
lsblk
