#!/bin/bash

ESC="\x1b["
RESET=$ESC"39;49;00m"
CYAN=$ESC"33;36m"
RED=$ESC"31;01m"
GREEN=$ESC"32;01m"

# warning 

function warning()
{	echo -e "\n$RED [!] $1 $RESET\n"
	}

function notification()
{	echo -e "\n$GREEN [+] $1 $RESET\n"
	}

function notification_b()
{	echo -e "\n$CYAN $1 $RESET\n"
	}
	

function dir_checker()
{
	printf "\nPlease provide the full path to the img file"
	printf " Usage: ~/home/$USER/disk.img\n"

	read -p 'Enter a location : ' image_dir
      	printf "\nChecking location...\n"

	sleep 1.5

	stat $image_dir >> /dev/null || warning "Can't find specified location" && reset=0	
	}


function mem_checker()
{
	printf "\nPlease provide the amount of memory you would like to allocate"
	printf " Usage: 512\n"

	read -p 'Enter memory allocation : ' mem_allocation
	printf "\nAllocating memory...\n"

	sleep 1.5
	}	

dir_checker
mem_checker

if [[ $reset == 1 ]]; then
	printf "The location you have specified for the image file appears to be invalid."
	read -p 'Retry? y/n : ' choice 

	if [ $choice == 'y' ]; then
		dir_checker
	else
		warning "Aborted."
	fi
fi

notification "Operation Completed"
printf "Starting QEMU" && sleep 2

qemu-system-x86_64 -enable-kvm ${@:-$image_dir} -m ${@:-$mem_allocation} -netdev tap,id=net1,ifname=tap1,script=no,downscript=no -device e1000,netdev=net1,mac=00:aa:00:60:00:02
