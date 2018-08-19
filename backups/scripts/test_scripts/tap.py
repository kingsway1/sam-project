#!/usr/bin/env python

import os
import sys
import time
from optparse import OptionParser

parser = OptionParser()
parser.add_option("-n", "--number", dest="number", help="Number of images you wish to spin up.", default=1)

(options, args) = parser.parse_args()

number=options.number

# add bridge
#os.system('ip link add virbr0 type bridge')
#os.system('ip link set eth0 master virbr0')
#os.system('ip link set dev eth0 up')
#os.system('ip link set dev virbr0 up')
#os.system('dhclient virbr0')
#os.system('ip addr flush dev eth0')
# add a loop in here

x = 0

while x < int(number):
    os.system('echo ip tuntap add dev tap%d mode tap user $(whoami)' % x)
    os.system('echo ip link set tap%d master virbr0' % x)
    os.system('echo ip link set dev tap%d up' % x)
    print "\n"
    x+=1
    time.sleep(1)




