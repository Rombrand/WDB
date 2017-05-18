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

packet72 1

sprachen=( "en" "de" "fr" "es" "ro" )

for ((i=0; i<5; i += 1));
do
	language ${sprachen[$i]}
	
	clock 60
	packet76 10 1 1 0
	read -p "Nächste Text Message"
	
	packet78 10
	
	clock 120
	packet76 20 1 1 1
	read -p "Nächste Text Message"
	
	packet78 20
done

packet72 0

echo "TestProgramm Acknowledge Indicators Endet."
