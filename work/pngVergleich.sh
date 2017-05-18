#!/bin/bash

ERR=0

#Bilder vergleichen
echo "ERR = $ERR"

compare ~/Schreibtisch/test0.png ~/Schreibtisch/test1.png ~/Schreibtisch/difference0.png

echo "ERR = $ERR"

if [ 0 -lt $ERR ]
	then
		echo "Error in picture compare."
	else
		echo "No Error in picture compare."
fi
