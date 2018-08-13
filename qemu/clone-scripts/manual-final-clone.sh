#!/bin/bash
#Sam Bohnel
#30/07/18

#README

#The system the script is running on must have at least two hard disks, the second hard disk must be bigger in size than the first hard disk.   

ESC="\x1b["
RESET=$ESC"39;49;00m"
GREEN=$ESC"32;01m"
CYAN=$ESC"33;36m"

function notification() 
{	echo -e "\n$GREEN [+] $1 $RESET\n"
}

function notification_b() 
{	echo -e "$CYAN $1 $RESET"
}

notification_b "  _______  _        _______  _        _______  "
notification_b " (  ____ \( \      (  ___  )( (    /|(  ____ \ "
notification_b " | (    \/| (      | (   ) ||  \  ( || (    \/ "
notification_b " | |      | |      | |   | ||   \ | || (__     "
notification_b " | |      | |      | |   | || (\ \) ||  __)    "
notification_b " | |      | |      | |   | || | \   || (       "
notification_b " | |      | |      | |   | || | \   || (       "
notification_b " (_______/(_______/(_______)|/    )_)(_______/ "
notification_b "                                               "

sleep 1.5

echo -e "\e[00;32m#################################################################\e[00m"
echo ""
echo "***   Disk Clone Automation Script  ***"
echo ""
echo -e "\e[00;32m#################################################################\e[00m"

sleep 1.5

#list partitions 

echo""
echo -e "\e[00;32m#################################################################\e[00m"
echo""
echo "***    Available hard disks     ***"
echo ""

fdisk -l

echo ""
echo -e "\e[00;32m#################################################################\e[00m"

sleep 1.5

echo " "
printf "Choose the disk you want to clone - for example /dev/sda \n"

read -p 'Choose a disk : ' disk
printf "\n Checking Disk...\n"
echo " "
sleep 1.5 

echo ""
printf "Choose location to clone the disk - for example /mnt \n"

read -p 'Choose a location : ' location
printf "\n Checking location...\n"
echo " " 
sleep 1.5

#copy disk to location

echo " "
printf "Copying $disk to $location..."
echo " "


dd if=/dev/sda of=$location/disk.img status=none

sleep 1.5
echo""
printf "\n$disk succesfully copied\n"
echo""
#verify if disk.img was succesfully created

#copy disk.img to qemu host 

#printf "copying disk to qemu host - select scp destination - for example root@192.168.33.159:/root\n"
#printf "scp disk.img " 
#read destination

#scp /mnt/$location/disk.img $destination

#if success then finish 
#else enter valid location

