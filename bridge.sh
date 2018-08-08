#!/bin/bash

# add bridge
ip link add virbr0 type bridge 

# add tap device 
ip tuntap add dev tap0 mode tap user $(whoami)

# connect interfaces to bridge  

ip link set eth0 master br0
ip link set eth0 master virbr0
ip link set tap0 master virbr0


# make sure interfaces are up 

ip link set dev eth0 up
ip link set dev virbr0 up
ip link set dev tap0 up

# assign bridge ip via dhcp 

dhclient virbr0

#remove ip from eth0 

ip addr flush dev eth0




