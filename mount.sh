#!/bin/bash
#Sam Bohnel
#30/07/18

#README

#The system the script is running on must have at least two hard disks, the second hard disk must be bigger in size than the first hard disk.   

echo -e "\e[00;32m#######################################################################\e[00m"
echo ""
echo "***   Disk Clone Automation Script  ***"
echo ""
echo -e "\e[00;32m#######################################################################\e[00m"


#list partitions 

echo""
echo -e "\e[00;32m#######################################################################\e[00m"
echo""
echo "***    Available hard disks     ***"
echo ""

fdisk -l

echo ""
echo -e "\e[00;32m######################################################################\e[00m"


#mount disk


printf "Choose the disk you want to mount - for example /dev/sdb1 \n"

read disk 

printf "Choose location to mount disk - for example /sdb1\n"

read location

mkdir /mnt/$location

mount $disk /mnt/$location

mount | grep /mnt/$location

#copy /dev/sda to mount point

printf "copying /dev/sda to disk.img file in mount point"

# hard coded at the moment - need to find a method for working out bs and count 
if mountpoint -q /mnt/$location
then 
   dd if=/dev/sda of=/mnt/$location/disk.img bs=1073741824 count=6
else
   echo "not mounted"
   #repeat stage - ensure its mounted
fi

#verify if disk.img was succesfully created

#copy disk.img to qemu host 

printf "copying disk to qemu host - select scp destination - for example root@192.168.33.159:/root\n"
printf "scp disk.img " 
read destination

scp /mnt/$location/disk.img $destination



#if success then finish 
#else enter valid location

