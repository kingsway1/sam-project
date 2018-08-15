#!/usr/bin/env python

import os
import sys
import time
from optparse import OptionParser
from os.path import expanduser

home_folder = os.getenv('HOME')
parser = OptionParser()
parser.add_option("-n", "--number", dest="number", help="Number of images you wish to spin up.", default=1)
parser.add_option("-f", "--filename", dest="filename", help="File you want to copy.", default=False)
parser.add_option("-l", "--location", dest="location", help="Save location.", default=home_folder)
(options, args) = parser.parse_args()

number=options.number
filename=options.filename
location=options.location

# add bridge
#os.system('ip link add virbr0 type bridge')
#os.system('ip link set eth0 master virbr0')
#os.system('ip link set dev eth0 up')
#os.system('ip link set dev virbr0 up')
#os.system('dhclient virbr0')
#os.system('ip addr flush dev eth0')

#create directories, copy files and set up tap devices -- will increment with each device
x = 0
while x < int(number):
    os.system('mkdir %s/copydir_%d' %(location, x))
    os.system('cp %s %s/copydir_%d/copy%d_of_%s' %(filename, location, x, x, number))
    os.system('echo ip tuntap add dev tap%d mode tap user $(whoami)' % x)
    os.system('echo ip link set tap%d master virbr0' % x)
    os.system('echo ip link set dev tap%d up' % x)
    x+=1
    time.sleep(1)

# populate database


