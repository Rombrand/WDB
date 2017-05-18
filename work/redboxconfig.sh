#!/bin/sh

HOST=$1
USER='root'
PASSWD='wmuepa09'


echo "> RedBox Aktualisierung (mrf aktualisieren und aktivieren)"

echo "> Löschen der Daten auf der Redbox: /mfr/"
sshpass -p $PASSWD ssh $USER@$1 'rm -rf /mfr'

echo "> fdp Verbindung für Datenübertragung"
ftp -n -v $HOST << EOT
ascii
user $USER $PASSWD
prompt
cd /tmp
binary
put mfr1-Release_1_0_VEK_Stimulator_2404_V*.tgz
bye
EOT

echo "> mfr1 Prozess stoppen"
sshpass -p $PASSWD ssh $USER@$1 'killall mfr1'

echo "> Software installieren"
sshpass -p $PASSWD ssh $USER@$1 'tar -vx -f /tmp/mfr1-Release_1_0_VEK_Stimulator_2404_V*.tgz -C /mfr/'
sshpass -p $PASSWD ssh $USER@$1 'rm /tmp/mfr1-Release_1_0_VEK_Stimulator_2404_V*.tgz'

echo "> /mfr aktivieren"
sshpass -p $PASSWD ssh $USER@$1 'rm /mfr2/.active'
sshpass -p $PASSWD ssh $USER@$1 'touch /mfr/.active'

echo "> Neustart"
sshpass -p $PASSWD ssh $USER@$1 'reboot;exit'
