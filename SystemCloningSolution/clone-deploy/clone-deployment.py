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

# call qemu-ifup script in /etc

os.system('/etc/qemu-ifup')

#create directories, copy files and set up tap devices -- will increment with each device
x = 0
y = 1
while x < int(number):
    os.system('mkdir %s/copydir_%d' %(location, y))
    os.system('cp %s %s/copydir_%d/copy%d_of_%s' %(filename, location, y, y, filename))
    os.system('ip tuntap add dev tap%d mode tap user $(whoami)' % y)
    os.system('ip link set tap%d master br0' % y)
    os.system('ip link set dev tap%d up' % y)
    x+=1
    y+=1
    time.sleep(1)

os.system ('echo %d clones created' %(x))


