#!/bin/bash
printf "Set Target: " 
read IP

nmap -sV $IP -oX scan.xml && xsltproc scan.xml -o "/root/samProject/nmapReports/$IP-`date +%d:%m:%y`_report.html" 

echo ""
printf "$IP-`date +%d:%m:%y`_report.html saved in /root/samProject/nmapReports"
echo ""
