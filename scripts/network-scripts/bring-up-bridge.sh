#!/bin/bash 

ip link set dev virbr0 up
ip addr flush dev eth0
