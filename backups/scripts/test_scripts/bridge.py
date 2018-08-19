#!/usr/bin/env python

import os
import sys

# add bridge
os.system('ip link add virbr0 type bridge')
os.system('ip link set eth0 master virbr0')
os.system('ip link set dev eth0 up')
os.system('ip link set dev virbr0 up')
#os.system('dhclient virbr0')
os.system('ip addr flush dev eth0')


# add a loop in here
os.system('ip tuntap add dev tap0 mode tap user $(whoami)')
os.system('ip link set tap0 master virbr0')
os.system('ip link set dev tap0 up')






