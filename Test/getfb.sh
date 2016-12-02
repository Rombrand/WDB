#!/bin/sh

HELP='Usage: getfb.sh user@hostname png-file-name [rotation_in_degree]'
TMP_FILE1=$(mktemp)
TMP_FILE2=$(mktemp)
TMP_FILE3=$(mktemp)

if [ $# -lt 2 ]
then
	echo ${HELP}
	exit 1
elif [ $# -gt 3 ]
then
	echo ${HELP}
	exit 1
fi
sshpass -p 'dat' ssh root@$1 "cat /dev/fb0 > ${TMP_FILE1}"
sshpass -p 'dat' scp root@$1:${TMP_FILE1} ${TMP_FILE2}
fbgrab -w 800 -h 480 -b 16 -f ${TMP_FILE2} ${TMP_FILE3}
convert ${TMP_FILE3} -rotate ${3:-0}90 "/home/chris/Schreibtisch/"$2".png"
