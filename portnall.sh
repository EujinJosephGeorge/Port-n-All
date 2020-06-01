#!/bin/bash
if [ "$1" == "" ]; then
echo -e "\e[1;32mYou Forgot the IP Address\e[0m"
echo -e "\e[1;32mSyntax: sudo ./portnall.sh\e[0m"
exit
else
nmap -T4 --min-rate=1000 -p- $1 | grep "/" | cut -d " " -f 1 | tr -d "/tcpud" > port.txt #Runs nmap to scan all ports. It greps for line with '/' and uses delimiter to remove spaces and selects the 1st field and then truncates the characters and wites the output to port.txt
sed '1d' port.txt > ports.txt #Uses sed to remove 1st line as it was unnecessary characters
tr '\n' ',' < ports.txt > allports.txt #Uses truncate to add comma so that the port number wont be in different line as it will rerun the code for each port
sleep 1
rm port.txt
rm ports.txt
echo
echo -e "\e[1;31m**********Port Scanning Complete**********\e[0m"
echo -e "\e[1;32mThe ports are\e[0m"
cat allports.txt
fi
echo 
echo
echo -e "\e[1;32mDoing a full scan on the Ports\e[0m"
echo
for ports in $(cat allports.txt); do nmap -T4 -p $ports -A $1 > Results.txt #Runs the nmap -A script for the discovered ports
echo -e "\e[1;31m**********Full scan Complete**********\e[0m"
echo
sleep 2 
echo -e "\e[1;32mThe results are\e[0m"
cat Results.txt
echo -e "\e[1;32mThe Open ports and Results are stored in portnall.txt and Results.txt respectively\e[0m"
echo -e "\e[1;31mThank You!\e[0m"
done
