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

MessageID=( 1   2   3   4   5   6   7   8   9  10  11  12  13  14 )
IconID=( 101 103 105 107 109 111 134 135 136 137 138 139 140 141 )

for ((i=0; i<14; i += 1));
do
	packet68 ${MessageID[$i]} 3 ${IconID[$i]}
	
	read -p "Icon "${IconID[$i]}" mit MessageID "${MessageID[$i]}" durch klicken auf Area C1 bestätigen. Danach weiter mit Enter"
done

packet68 15 6 1

read -p "Icon "1" mit MessageID "15" durch klicken auf Area C9 bestätigen. Danach weiter mit Enter"

echo "TestProgramm Acknowledge Indicators Endet."
