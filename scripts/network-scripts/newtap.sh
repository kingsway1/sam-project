#!/bin/bash
ip tuntap add dev tap2 mode tap user $(whoami)
ip link set tap2 master virbr0
ip link set dev tap2 up

