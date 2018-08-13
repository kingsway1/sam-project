#!/bin/bash

ESC="\x1b["
RESET=$ESC"39;49;00m"
CYAN=$ESC"33;36m"
RED=$ESC"31;01m"
GREEN=$ESC"32;01m"

function warning()
{       echo -e "\n$RED [!] $1 $RESET\n"
	        }

function notification()
{       echo -e "\n$GREEN [+] $1 $RESET\n"
	        }

function notification_b()
{       echo -e "\n$CYAN $1 $RESET\n"
	        }


printf "\n\nPlease choose the image file to deploy. \n\n"

read -p 'Enter the full path to the image file : ' image_file

printf "\n\nPlease select the number of clones to deploy. \n\n"

read -p 'Enter number of clones : ' clone_number

printf "\n\nPlease enter the location to deploy the clones. \n\n"

read -p 'Enter the full path to the directory  : ' dir_location

sleep 1.5

cd $dir_location >>/dev/null || warning "location not found, creating directory" && mkdir $dir_location && cd $dir_location 

COUNTER=0

while [  $COUNTER -le $clone_number ]; do
	echo "creating clone 1, 2, 3 etc"
        mkdir image1
	cp $image_file image1
	let COUNTER=COUNTER+1
done 
		

