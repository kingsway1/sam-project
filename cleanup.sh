#!/bin/bash

# remove bridge & tap device and assign ip to eth0 


# remove tap interface from bridge

brctl delif virbr0 tap0

# delete tap interface 

tunctl -d tap0

# remove eth0 from bridge 

brctl delif virbr0 eth0

# bring bridge down

ifconfig virbr0 down

# remover bridge

brctl delbr virbr0

# bring eth0 up 

ifconfig eth0 up

# if eth0 not assigned IP - dhclient eth0 


