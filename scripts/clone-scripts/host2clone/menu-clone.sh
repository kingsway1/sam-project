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


dd if=$disk of=$location/disk.img status=none

if [ $(blockdev --getsize64 $disk) -ne $(stat -c %s $location/disk.img) ]; then
    echo " "
    echo " "
    rm $location/disk.img 
    printf "\n$disk Unsuccesfully copied, please run the script again and enter a vailid disk\n"
    printf "\nExiting...\n"
    sleep 1.5
    exit 1
    echo " "
    echo " "
else
    echo " "
    echo " "
    printf "\n$disk succesfully copied\n"
    echo " "
    echo " "
    printf "\n Do you wish to tranfer the disk.img file to a different host, such as a QEMU host?"
    read -p 'yes or no? y/n : ' choice
    if [ $choice == 'y']; then
	   printf "\n Select the host to transfer the disk.img to, e.g user@192.168.x.x\n"
	   read -p 'Enter host : ' host
	   echo " "
	   printf "\n Select a directory on the host machine to copy the disk.img file to, e.g /home/$USER/\n"
	   read -p 'Enter directory' dir
	   scp $location/disk.img $host:$dir
	   if [ $? -eq 0]; then
		   echo " "
		   printf "\n disk.img successfully copied to $host:$dir\n"
		   echo " "
 	   else
		   echo " "
		   printf "\n disk.img was unsuccessfully transfered to $host:$location, Parametres were possibly wrong, try a manual scp"
		   printf "\n $disk is saved in $location/disk.img"
		   echo " "
		   printf"\n Exiting..."
		   sleep 1.5
		   exit 1
	   fi
	
    else    
	   echo " "
	   printf "\n $disk is saved in $location/disk.img"
	   printf "\n Exiting..."
	   sleep 1.5
	   exit 1
    fi	    
fi
