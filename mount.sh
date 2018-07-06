#!/bin/bash


#list partitions 

printf "Available hard disks\n\n"


sudo fdisk -l

#mount disk

printf "Choose the disk you want to mount - for example /dev/sdb1 \n"

read disk 

printf "Choose location to mount disk - for example /img\n"

read location

sudo mkdir /mnt/$location

sudo mount $disk /mnt/$location

if mountpoint -q /mnt/$location
then 
   echo "mounted"
else
   echo "not mounted"
fi


