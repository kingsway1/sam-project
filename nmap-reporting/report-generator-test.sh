#!/bin/bash

ScriptDir = "/usr/share/nmap/scripts/"
printf "Set Target:  \n"
read IP
x = []
for i in os.listdir(ScriptDir):
	grep "safe" > x
	for i in x:
		read i
nmap -sV $IP --script=ScriptDir$i -oX scan.xml && xsltproc scan.xml -o "/root/samProject/nmapReports/`date +%d%m%y`_report.html"

