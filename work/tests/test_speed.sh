#!/bin/bash

source yaml_stimulator.sh

# Starten mit oder ohne Stimulator
# $1 Parameter1 403 oder 401 (BR)

function speed()
{
for ((i=0; i<=$1; i += 1));
do
	speedAnalog $i
	speedDigital $i
	sleep 3
	
	getData "PD_D1_CA_MINOR_FAILURE"
	
	if [ "$?" == 1 ]
	then
		echo "Speed Fehler" $i "km/h"
		echo "Speed Fehler" $i "km/h" >> log/speedError_$d.log
	fi
done
}

# Das Hauptprogramm
if [ $# -gt 0 ]
then
	./test_startup.sh $1
else
	./test_startup.sh
fi

d=$(date +%y_%m_%d_%H_%M_%S)

echo "Speed Fehler log" >> log/speedError_$d.log
echo "ETCS Mode:" >> log/speedError_$d.log

mode 255 

for ((j=0; j<=6; j += 1));
do
	if [ "$j" == 2 ]
	then
		j=4
	fi
	
	echo "Farbe " $j ":" >> log/speedError_$d.log
	setData "M_COLOUR_SP" $j
	speed 1023
done

echo "PZB/LZB Mode:" >> log/speedError_$d.log

mode 9
speed 1023
mode 255

speedAnalog 0
speedDigital 0
displayIndicator 04 1 1

sleep 3

getData "PD_D1_CA_MINOR_FAILURE"

if [ "$?" == 1 ]
then
	displayIndicator 04 "" ""
	echo "TestProgramm Speed check beendet."
	echo "TestProgramm Speed check beendet." >> log/speedError_$d.log 
else
	displayIndicator 04 "" ""
	echo "Ein Fehler ist aufgetretten!!!"
	echo "Ein Fehler ist aufgetretten!!!" >> log/speedError_$d.log 
fi

echo " " >> log/speedError_$d.log
