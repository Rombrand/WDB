#!/bin/sh

# Virtuelle IP-Adresse für den TestBereich in Bergisch Gladbach
#sudo ifconfig enp9s0 add 192.168.4.178

case $1 in

mvb401)
echo "Starting stimulator with \"ETCS MVB BR 401\" simufile and startaut from Squish on port 10001 -->"
/home/chris/Programme/squish-6.0.1-qt55x-linux64/bin/startaut --port=10001 /home/chris/Dokumente/deuta/build-Stimulator-Desktop-Release/Stimulator -f/home/chris/Dokumente/deuta/dmi-projects/05-Implementation/src-cmake/sim2/ui/Alstom_BL3_dmi_mvb.simu &
;;

mvb403)
echo "Starting stimulator with \"ETCS MVB BR 403\" simufile and startaut from Squish on port 10001 -->"
/home/chris/Programme/squish-6.0.1-qt55x-linux64/bin/startaut --port=10001 /home/chris/Dokumente/deuta/build-Stimulator-Desktop-Release/Stimulator -f/home/chris/Dokumente/deuta/dmi-projects/05-Implementation/src-cmake/sim2/ui/Alstom_BL3_dmi_mvb_br403.simu &
;;

udp401)
echo "Starting stimulator with \"ETCS UDP BR 401\" simufile -->"
/home/chris/Dokumente/deuta/build-Stimulator-Desktop-Release/Stimulator -f/home/chris/Dokumente/deuta/dmi-projects/05-Implementation/src-cmake/sim2/ui/Alstom_BL3_dmi_udp.simu &
;;

udp403)
echo "Starting stimulator with \"ETCS UDP BR 403\" simufile -->"
/home/chris/Dokumente/deuta/build-Stimulator-Desktop-Release/Stimulator -f/home/chris/Dokumente/deuta/dmi-projects/05-Implementation/src-cmake/sim2/ui/Alstom_BL3_dmi_udp_br403.simu &
;;

esbo82)
echo "Starting stimulator with \"Siemens ESBO8.2 MVB\" simufile -->"
/home/chris/Dokumente/deuta/build-Stimulator-Desktop-Release/Stimulator -f/home/chris/Dokumente/deuta/berlin/dmi-projects/05-Implementation/src-cmake/sim2/ui/SiemensDMI_ESBO_82_mvb.simu &
;;

esbo)
echo "Starting stimulator with \"Siemens DMI MVB\" simufile -->"
/home/chris/Dokumente/deuta/build-Stimulator-Desktop-Release/Stimulator -f/home/chris/Dokumente/deuta/berlin/dmi-projects/05-Implementation/src-cmake/sim2/ui/Siemens_dmi_mvb.simu &
;;

*)
echo "Kein oder unbekannte Datei angegeben!"
echo "Starting stimulator without simufile -->"
/home/chris/Programme/squish-6.0.1-qt55x-linux64/bin/startaut --port=10001 /home/chris/Dokumente/deuta/build-Stimulator-Desktop-Release/Stimulator &
;;

esac 
