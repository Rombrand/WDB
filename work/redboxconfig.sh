#!/bin/sh

    echo ""
    echo "An Release von Jenkins Build Job | MFR1_BUILD_configuration_Fast | anpassen"
    echo ""
    read input
    let DEBUG="$input"

    if [ "$DEBUG" == "1" ]
    then
        # Teststand IP-adressen
	#sudo ifconfig eth0 add 192.168.4.178
        echo ""
        echo "Löschen der Daten auf der Redbox: rm -rf /mfr/"
        echo ""
        ssh root@$1 'rm -rf /mfr'
        # upload new redBox aplication (unter downloads abzulegen)
        scp '~/Downloads/0_VEK_Stimulator_2404_V1_Alstom_BUILD_*-*-VEK_Stimulator_2404_V1_Alstom.tgz' root@192.168.4.177:/tmp
        sshpass -p 'dat' ssh root@$1 'mv /home/startup /home/startup_'
        sshpass -p 'dat' ssh root@$1 'killall mfr1'
        sshpass -p 'dat' ssh root@$1 'tar -vx -f /tmp/mfr1-Release_1_0_VEK_Stimulator_2404_V1_Alstom_BUILD_*-*-VEK_Stimulator_2404_V1_Alstom.tgz -C /mfr/'
        sshpass -p 'dat' ssh root@$1 'rm /tmp/mfr1-Release_1_0_VEK_Stimulator_2404_V1_Alstom_BUILD_*-*-VEK_Stimulator_2404_V1_Alstom.tgz'
        sshpass -p 'dat' ssh root@$1 'rm /mfr2/.active'
        sshpass -p 'dat' ssh root@$1 'touch /mfr/.active'
        sshpass -p 'dat' ssh root@$1 '/mfr/./mfr1.sh'
        sshpass -p 'dat' ssh root@$1 'reboot;exit'
        sleep 30s
        sshpass -p 'dat' ssh root@$1 '/mfr/./mfr1.sh'
        sshpass -p 'dat' ssh root@$1 'mv /home/startup_ /home/startup'
    fi
fi
