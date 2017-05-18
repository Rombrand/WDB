#!/bin/bash

## Set data
# Parameter: 1.DataName; 2.value
function setData()
{
nc -q 1 127.0.0.1 1234 <<EOF
---
method: set
object: "$1"
properties: 
    objValue: "$2"
userData: $1 = $2
...
EOF
}

## Get data
# Parameter: 1.DataName
# Sehr wichtig Objektname richtig schreibenk (keine Fehlermeldung)
function getData()
{

export tmp=$(nc -q 1 127.0.0.1 1234 <<EOF
---
method: get
object: "$1"
...
EOF
)

if [[ $tmp == *"objValue: 1"* ]]
then
	value=1

elif [[ $tmp == *"objValue: 0"* ]]
then
	value=0

fi

return $value
}

## Indicatoren
#  Parameter: 1.IndicatorID; 2.Icon; 3.Visibility
function displayIndicator()
{
tmp="PD_ETCS_INDIC_"$1"_CONTENT"

nc -q 1 127.0.0.1 1234 <<EOF
---
method: set
object: "$tmp"
properties: 
    objValue: "$2"
userData: icon = $2
...
EOF

tmp="PD_ETCS_Q_DISPLAY_INDIC_"$1

nc -q 1 127.0.0.1 1234 <<EOF
---
method: set
object: "$tmp"
properties: 
    objValue: "$3"
userData: visibility = $3
...
EOF

}

## Analog speed
#  Parameter: 1.speed in km/h analog
function speedAnalog()
{
nc -q 1 127.0.0.1 1234 <<EOF
---
method: set
object: "V_TRAIN_ANALOG"
properties: 
    objValue: "$1"
userData: analog speed $1
...
EOF
}

## Digital speed
#  Parameter: 1.speed in km/h digital
function speedDigital()
{
nc -q 1 127.0.0.1 1234 <<EOF
---
method: set
object: "P71_DMI_V_NUM"
properties: 
    objValue: "$1"
userData: digital speed $1
...
EOF
}

## Language
#  Parameter: 1.language (de/en/fr/es/ro)
function language()
{
nc -q 1 127.0.0.1 1234 <<EOF
---
method: set
object: "P30_ETCS_NID_DRV_LANG"
properties: 
    objValue: "$1"
userData: language $1
...
EOF
}

## Date and Time
#  Parameter: 1.Unix time (+30 years)
function clock()
{
nc -q 1 127.0.0.1 1234 <<EOF
---
method: set
object: "P17_DMI_T_CLOCK"
properties: 
    objValue: $1
userData: time $1
...
EOF
}

## Change mode
#  Parameter: 1.Mode(ETCS[255]/PZB/LZB[9])
function mode()
{
nc -q 1 127.0.0.1 1234 <<EOF
---
method: set
object: "PD_ETCS_NID_STM_ACCEPTANCE"
properties: 
    objValue: $1
userData: set mode $1
...
EOF
}

## send
#  Parameter: no
function send()
{
nc -q 1 127.0.0.1 1234 <<EOF
---
method: send
object: Message_EVC_to_DMI
userData: send
...
EOF
}

## Choose packets and add one
#  Parameter: no
function addPacket()
{
nc -q 1 127.0.0.1 1234 <<EOF
---
method: set
object: ApplicationTelegram/MessageContentType
properties:
  objValue: Packets
userData: choose packets
...

---
method: add
object: Message_EVC_to_DMI/CRCGroup/ApplicationTelegram/MessageContentType/Packets
userData: add
...
EOF
}

## Packete löschen geht noch nicht !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#  Parameter: no
function deletePacket()
{
nc -q 1 127.0.0.1 1234 <<EOF
---
object: Packets
method: delete
userData: auf delete klicken
...
EOF
}

## Startup
#  Parameter: no
function startup()
{
#Safetylayer aufbauen
nc -q 1 127.0.0.1 1234 <<EOF
---
method: send
object: Message_EVC_to_DMI_ConReq
userData: Saftylayer aufbauen
...
EOF

# Startup auswählen und senden
nc -q 1 127.0.0.1 1234 <<EOF
---
method: set
object: ApplicationTelegram/MessageContentType
properties:
  objValue: Startup
userData: Startup auswählen
...

---
method: send
object: Message_EVC_to_DMI
userData: Startup senden
...
EOF

addPacket
}

## Packet 02
#  Parameter: 1.MessageID;
function packet02()
{
nc -q 1 127.0.0.1 1234 <<EOF
---
basePath: MSG_EVC_-->_DMI
object: Message_EVC_to_DMI/CRCGroup/ApplicationTelegram/MessageContentType/Packets/Packet
properties:
    objValue: "Packet 02: Delete instantiated element (from EVC to DMI)"
userData: Packet02
...

---
basePath: MSG_EVC_-->_DMI
object: "Packet 02: Delete instantiated element (from EVC to DMI)/content/NID_TEXT"
properties:
    objValue: $1
userData: MessageID $1 
...

---
method: send
object: Message_EVC_to_DMI
userData: send
...
EOF
}

## Packet 03
#  Parameter: Ticket 3568
function packet03()
{
nc -q 1 127.0.0.1 1234 <<EOF
---
basePath: MSG_EVC_-->_DMI
object: Message_EVC_to_DMI/CRCGroup/ApplicationTelegram/MessageContentType/Packets/Packet
properties:
    objValue: "Packet 03: Confirmation request (from EVC to DMI)"
userData: Packet03
...

---
method: add
object: "Packet 03: Confirmation request (from EVC to DMI)/content/TextFields"
userData: add
...

---
method: add
object: "Packet 03: Confirmation request (from EVC to DMI)/content/Fields"
userData: add
...
EOF
}

## Packet 09
#  Parameter: 1.Message; 2.Attrinute; 3.Q_ACK; 4.Q_PRIORITY; 5.Q_Text; 6.X_Text
function packet09()
{
nc -q 1 127.0.0.1 1234 <<EOF
---
basePath: MSG_EVC_-->_DMI
object: Message_EVC_to_DMI/CRCGroup/ApplicationTelegram/MessageContentType/Packets/Packet
properties:
    objValue: "Packet 09: EVC Text message (from EVC to DMI)"
userData: Packet09
...

---
basePath: MSG_EVC_-->_DMI
object: "Packet 09: EVC Text message (from EVC to DMI)/content/NID_EVC_MESSAGE"
properties:
    objValue: $1
userData: MessageID $1
...

---
basePath: MSG_EVC_-->_DMI
object: "Packet 09: EVC Text message (from EVC to DMI)/content/M_ATTRIBUTE/ATTRIBUTE_DEFAULT"
properties:
    objValue: $2
userData: Attribute $2
...

---
basePath: MSG_EVC_-->_DMI
object: "Packet 09: EVC Text message (from EVC to DMI)/content/Q_ACK"
properties:
    objValue: $3
userData: Q_ACK $3
...

---
basePath: MSG_EVC_-->_DMI
object: "Packet 09: EVC Text message (from EVC to DMI)/content/Q_PRIORITY"
properties:
    objValue: $4
userData: Q_PRIORITY $4
...

---
basePath: MSG_EVC_-->_DMI
object: "Packet 09: EVC Text message (from EVC to DMI)/content/Q_TEXT/PLAIN_TEXT"
properties:
    objValue: $5
userData: Text $5
...

---
basePath: MSG_EVC_-->_DMI
object: "Packet 09: EVC Text message (from EVC to DMI)/content/X_TEXT/"
properties:
    objValue: "$6"
userData: Test $6
...

---
method: send
object: Message_EVC_to_DMI
userData: send
...
EOF
}

## Packet 41 									GEHT NOCH NICHT !!!
#  Parameter: 1.WindowID; 2.Hour_Glass
function packet41()
{
echo "0"

WindowID=( "--" "DEFAULT_MENU" "MAIN_MENU" "OVERRIDE_MENU" "SETTINGS_MENU" "SPECIAL_MENU" "RBC_CONTACT_MENU" "NTC_DATA_ENTRY_SELECTION_MENU" "MAINTENANCE_PARAMETERS_MENU" "KEY_MANAGMENT_MENU" "MAINTENANCE_DIAGNOCE_MENU" "ACCELEROMETER_CALIBRATION_MENU" )
Hour_Glass=( "OFF" "ON" )

echo "1"

nc -q 1 127.0.0.1 1234 <<EOF
---
basePath: MSG_EVC_-->_DMI
object: Message_EVC_to_DMI/CRCGroup/ApplicationTelegram/MessageContentType/Packets/Packet
properties:
    objValue: "Packet 41: Menu window request (from EVC to DMI)"
userData: Packet41
...

---
basePath: MSG_EVC_-->_DMI
object: "Packet 41: Menu window request (from EVC to DMI)/content/DMI_M_MENU_WINDOW"
properties:
    objValue: ${WindowID[$1]}
userData: WindowID ${WindowID[$1]}
...

---
basePath: MSG_EVC_-->_DMI
object: "Packet 41: Menu window request (from EVC to DMI)/content/DMI_Q_HOUR_GLASS"
properties:
    objValue: ${Hour_Glass[$2]}
userData: Hour_Glass ${Hour_Glass[$2]}
...

nc -q 1 127.0.0.1 1234 <<EOF
---
method: send
object: Message_EVC_to_DMI
userData: send
...
EOF

}

## Packet 68
#  Parameter: 1.MessageID; 2.Indicator(C3/C9); 3.Icon
function packet68()
{
nc -q 1 127.0.0.1 1234 <<EOF
---
basePath: MSG_EVC_-->_DMI
object: Message_EVC_to_DMI/CRCGroup/ApplicationTelegram/MessageContentType/Packets/Packet
properties:
    objValue: "Packet 68: Acknowledgeable indicator (from EVC to DMI)"
userData: Packet68
...

---
basePath: MSG_EVC_-->_DMI
object: "Packet 68: Acknowledgeable indicator (from EVC to DMI)/content/NID_EVC_MESSAGE"
properties:
    objValue: $1
userData: MessageID $1
...

---
basePath: MSG_EVC_-->_DMI
object: "Packet 68: Acknowledgeable indicator (from EVC to DMI)/content/NID_EVC_ICON"
properties:
    objValue: $3
userData: Icon $3
...
EOF

# Area C9
if [ "$2" == 6 ]
then

nc -q 1 127.0.0.1 1234 <<EOF
---
basePath: MSG_EVC_-->_DMI
object: "Packet 68: Acknowledgeable indicator (from EVC to DMI)/content/NID_EVC_INDICATOR"
properties:
    objValue: "Indicator C9"
userData: Indicator C9
...
EOF

# Area C1
elif [ "$2" == 3 ]
then

nc -q 1 127.0.0.1 1234 <<EOF
---
basePath: MSG_EVC_-->_DMI
object: "Packet 68: Acknowledgeable indicator (from EVC to DMI)/content/NID_EVC_INDICATOR"
properties:
    objValue: "Indicator C1"
userData: Indicator C1
...
EOF
fi

nc -q 1 127.0.0.1 1234 <<EOF
---
method: send
object: Message_EVC_to_DMI
userData: send
...
EOF

}

## Packet 72
#  Parameter: 1.Question_BOX_Flag;
function packet72()
{
nc -q 1 127.0.0.1 1234 <<EOF
---
basePath: MSG_EVC_-->_DMI
object: Message_EVC_to_DMI/CRCGroup/ApplicationTelegram/MessageContentType/Packets/Packet
properties:
    objValue: "Packet 72: Question box request (from EVC to DMI)"
userData: Packet72
...

---
basePath: MSG_EVC_-->_DMI
object: "Packet 72: Question box request (from EVC to DMI)/content/DMI_Q_DISPLAY_QUESTION_BOX"
properties:
    objValue: $1
userData: question box $1
...

---
method: send
object: Message_EVC_to_DMI
userData: send
...
EOF
}

## Packet 76
#  Parameter: 1.Message; 2.Q_TESTCLASS; 3.Q_TEXTACK; 4.Q_TEXT Nochmal
function packet76()
{
nc -q 1 127.0.0.1 1234 <<EOF
---
basePath: MSG_EVC_-->_DMI
object: Message_EVC_to_DMI/CRCGroup/ApplicationTelegram/MessageContentType/Packets/Packet
properties:
    objValue: "Packet 76: Fixed text messages (from EVC to DMI)"
userData: Packet76
...

---
basePath: MSG_EVC_-->_DMI
object: "Packet 76: Fixed text messages (from EVC to DMI)/content/NID_TRACK_MESSAGE"
properties:
    objValue: $1
userData: MessageID $1
...

---
basePath: MSG_EVC_-->_DMI
object: "Packet 76: Fixed text messages (from EVC to DMI)/content/Q_TEXTCLASS"
properties:
    objValue: $2
userData: Q_TESTCLASS $2
...

---
basePath: MSG_EVC_-->_DMI
object: "Packet 76: Fixed text messages (from EVC to DMI)/content/Q_TEXTACK"
properties:
    objValue: $3
userData: Q_TEXTACK $3
...

---
basePath: MSG_EVC_-->_DMI
object: "Packet 76: Fixed text messages (from EVC to DMI)/content/Q_TEXT/LEVEL_CROSSING"
properties:
    objValue: $4
userData: Q_TEXT $4
...

---
method: send
object: Message_EVC_to_DMI
userData: send
...
EOF
}

## Packet 78
#  Parameter: 1.MessageID;
function packet78()
{
# Packet 78 auswählen
nc -q 1 127.0.0.1 1234 <<EOF
---
basePath: MSG_EVC_-->_DMI
object: Message_EVC_to_DMI/CRCGroup/ApplicationTelegram/MessageContentType/Packets/Packet
properties:
    objValue: "Packet 78: Delete track text message (from EVC to DMI)"
userData: Packet78
...

---
basePath: MSG_EVC_-->_DMI
object: "Packet 78: Delete track text message (from EVC to DMI)/content/NID_TEXT"
properties:
    objValue: $1
userData: MessageID $1
...

---
method: send
object: Message_EVC_to_DMI
userData: send
...
EOF
}

