#!/bin/bash

case $2 in

beep)
sshpass -p 'dat' ssh root@$1 'echo -e -n "ats41=1\r" > /dev/ttyO4;exit'
;;

ledon)
sshpass -p 'dat' ssh root@$1 'echo -e -n "ats117=254\r" > /dev/ttyO4;exit'
;;

ledoff)
sshpass -p 'dat' ssh root@$1 'echo -e -n "ats117=1\r" > /dev/ttyO4;exit'
;;

reboot)
sshpass -p 'dat' ssh root@$1 'reboot;exit'
;;

esac 

exit

