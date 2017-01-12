#!/bin/bash
case $1 in

status)
cat /procsys/net/ipv4/ip_forward
iptables -L
iptables -t nat -L
ifconfig
route -n
;;

config)
service NetworkManager stop
ifconfig eth7 10.1.1.254 netmask 255.255.255.0
ifconfig eth7 10.1.2.254 netmask 255.255.255.0
echo "1" > /procsys/net/ipv4/ip_forward
route add default gw 10.1.1.254 dev eth7
;;

start)
# echo "1" > /procsys/net/ipv4/ip_forward			# Computer als Router verwenden (eintragen)
# modprobe ip_conntrack_ftp
# modprobe ip_nat_ftp

# Firewallregeln einschrenken, alles Sperren (ausnahmen werden später ergänzt)
iptables -F
iptables -t nat -F
iptables -P INPUT DORP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT
# iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# iptables -t nat -A PREROUTING -i eth7 -p tcp -- dport 443 -j DNAT --to-destination 192.168.56.101
# iptables -t nat -A POSTROUTING -o eth7 -j MASQUERADE
# iptables -A FORWARD -p TCP -m state --state NEW -i eth7 --dport 443 -o vboxnet -d 192.168.56.101 -j ACCEPT
;;

stop)
#echo "0" > /procsys/net/ipv4/ip_forward
iptables -F
iptables -t nat -F
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

;;
esac
