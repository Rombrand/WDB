#!/bin/bash

#generic-dmi dir.
BASE_DIR=$(readlink -f $(dirname $0)/../05-Implementation)
STIMULATOR_DIR=$(readlink -f $BASE_DIR/../../stimulator)
for i in $BASE_DIR/build* ; do
  WORK_DIR=$i
  break
done
echo "Base       : $BASE_DIR"
echo "Stimulator : $STIMULATOR_DIR"
echo "Work       : $WORK_DIR"

#BASE_DIR=/home/dmidev/dev/dmi-alstom/05-Implementation
#WORK_DIR=$BASE_DIR/build-test
GENERIC_DMI_DIR=$WORK_DIR/generic-dmi
GENERIC_GATEWAY_DIR=$WORK_DIR/generic-gateway/src/generic-gateway-build
#STIMULATOR_DIR=/home/dmidev/dev/stimulator

#kill current gateway processes if any
killall Generic-Gateway

#kill current dmi processes if any
dmi_pids=$(pidof dmi)
if [[ ! -z $dmi_pids ]]; then
    killall dmi
fi

#set session LD_LIBRARY_PATH 
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$GENERIC_DMI_DIR/lib

#start left gateway
source $BASE_DIR/target/configs/dmi_settings_local_master.sh
nohup $GENERIC_GATEWAY_DIR/Generic-Gateway $BASE_DIR/target/configs/gateway/gateway_host.cfg -bleft -dcabA 2>&1 > tl-gw-left.log &
nohup $GENERIC_DMI_DIR/bin/dmi $GENERIC_DMI_DIR/cfg/dmi.cfg 2>&1 > tl-left.log &

sleep 1

#start right gateway
source $BASE_DIR/target/configs/dmi_settings_local_slave.sh
nohup $GENERIC_GATEWAY_DIR/Generic-Gateway $BASE_DIR/target/configs/gateway/gateway_host.cfg -bright -dcabA 2>&1 > tl-gw-right.log &
$GENERIC_DMI_DIR/bin/dmi $GENERIC_DMI_DIR/cfg/dmi.cfg 2>&1 > tl-right.log &

sleep 2

#start stimulators if necessary
#stimulator_pids=$(pidof Stimulator)
#if [[ -z $stimulator_pids ]]; then
#    $STIMULATOR_DIR/Stimulator -f$BASE_DIR/src-cmake/sim2/ui/scmt_dmi_udp.simu -s &
#    echo ""
#fi

sleep 1

