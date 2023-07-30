#!/bin/sh

killall cupsd
echo "Waiting for stop cups & cupsd ...."
sleep 3
chmod 777 -R SAM4SLinuxDriver
cd SAM4SLinuxDriver/Installer/SAM4S_Qt_Based_Installer/
/etc/init.d/cups stop
sleep 1
/etc/init.d/cups start /etc/cups/cupsd.conf
echo "Waiting for update cups & cupsd..."
sleep 3
./SAM4S_Qt_Based_Installer

