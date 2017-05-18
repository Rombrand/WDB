#!/bin/bash

source yaml_stimulator.sh

if [ $# -gt 0 ]
then
    if [ $1 == "403" ]
    then
        stimulator.sh mvb403auto > /dev/null &
        sleep 10
    elif [ $1 == "401" ]
    then
        stimulator.sh mvb401auto > /dev/null &
        sleep 10
    fi
fi

#Helligkeit auf 10 setzen
setData "F_TRINT_Brightness" 10

startup
