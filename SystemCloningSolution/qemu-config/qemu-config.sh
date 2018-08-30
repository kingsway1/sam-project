#!/bin/bash

ESC="\x1b["
RESET=$ESC"39;49;00m"
RED=$ESC"31;01m"
GREEN=$ESC"32;01m"

# warning notification 
function warning()
{	echo -e "\n$RED [!] $1 $RESET\n"
	}

# success notification 
function notification()
{	echo -e "\n$GREEN [+] $1 $RESET\n"
	}
	
function dir_checker()
{
	printf "\nPlease provide the full path to the img file"
	printf " Usage: /home/$USER/disk.img\n"

	read -p 'Enter a location : ' image_dir
      	printf "\nChecking location...\n"

	sleep 1.5
	
	#peforms a check on the input directory to ensure its valid and redirects output to /dev/null
	stat $image_dir 1>/dev/null 2>/dev/null || reset=1
	}

function mem_checker()
{
	printf "\nPlease provide the amount of memory you would like to allocate"
	printf " Usage: 512\n"

	read -p 'Enter memory allocation : ' mem_allocation
	printf "\nAllocating memory...\n"

	sleep 1.5
	}	

function tap_dev()
{	printf "\nPlease provide a tap device"
	printf " Usage: tap0\n"

	read -p 'Enter tap device : ' tap_allocation
	printf "\nAssigning tap device...\n"

	sleep 1.5
	}	

dir_checker

if [ "$reset" == 1 ]; then
	warning "Invalid Location"
	printf "The location you have specified for the image file appears to be invalid.\n"
	read -p 'Retry? y/n : ' choice 

	if [ "$choice" == 'y' ]; then
		dir_checker
	else
		warning "Aborted."
		sleep 1.5
		exit 1
	fi
fi

mem_checker

tap_dev

if grep "up" /sys/class/net/$tap_allocation/operstate > /dev/null
then
	warning "Tap Device busy"
        printf "The Tap device is busy, enter a unused tap device\n"
	read -p 'Retry? y/n : ' decision
	if [ "$decision" == 'y' ]; then
		tap_dev
	else 
       		warning "Aborted"
		sleep 1.5
		exit 1
	fi
fi

notification "Operation Completed"
printf "Beginning QEMU..." && sleep 2

qemu-system-x86_64 -enable-kvm ${@:-$image_dir} -m ${@:-$mem_allocation} -net nic -net tap,ifname=${@:-$tap_allocation},script=no,downscript=no 
