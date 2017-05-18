#!/bin/bash

source yaml_stimulator.sh

# Startent mit oder ohne Stimulator
# $1 Parameter1 403 oder 401 (BR)

if [ $# -gt 0 ]
then
	./test_startup.sh $1
else
	./test_startup.sh
fi

mode 255

setData "PD_ETCS_POSITIVE_VERIF_ON" 1
setData "PD_ETCS_POSITIVE_VERIF_FRESH" 2

displayIndicator 04 0 3

displayIndicator 04 3 2

displayIndicator 04 3 2

merker=0

sleep 2

for ((i=3; i<=15; i += 1));
do
	while [ $merker != 0 ]
	do
		getData "PD_D1_CA_MINOR_FAILURE"
		
		if [ "$?" == 0 ]
		then
			merker=0
		fi
	done
	
	displayIndicator 04 $i 1
	
	while [ $merker != 1 ]
	do
		getData "PD_D1_CA_MINOR_FAILURE"
		
		if [ "$?" == 1 ]
		then
			merker=1
		fi
	done
done

mode 9

displayIndicator 04 10 1

displayIndicator 04 13 1

displayIndicator 04 "" ""

echo "TestProgramm Area B7 Indicatoren zu Endet."
