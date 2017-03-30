#!/bin/bash

#This script is launched automatically in Erle-Brain 2
#on every boot and loads the autopilot

RPIPROC=$(cat /proc/cpuinfo |grep "Hardware" | awk '{print $3}')
if [ "$RPIPROC" == "BCM2708" ]; then
	#echo "Raspberry Pi 1/0"
	APM_BIN_DIR="/home/erle/PXFmini"
else
	APM_BIN_DIR="/home/erle"
	#echo "Raspberry Pi 2"
fi

FLAGS="-l /home/erle/APM/logs -t /home/erle/APM/terrain/"

date
while :; do
	$APM_BIN_DIR/ArduCopter.elf -A /dev/ttyUSB0 -B /dev/ttyAMA0 -C tcp:0.0.0.0:6001 $FLAGS
done >> /home/erle/APM/info/copter.log 2>&1
