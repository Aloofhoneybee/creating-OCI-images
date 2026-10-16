#!/bin/bash

mkdir -p rootfs/etc 
mkdir -p rootfs/usr/bin

echo -e "oci-practice \n another line" > rootfs/etc/hostname

echo "hello from my rootfs" > rootfs/usr/bin/hello
