#!/bin/sh
SERVER_IP=192.168.1.95
# Flushing all rules
iptables -F
iptables -X
# Setting default filter policy
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
# Allow unlimited traffic on loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
#allow http
sudo iptables -A INPUT -p udp -m udp --sport 53 -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --sport 80 -j ACCEPT

#allow inbound
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow incoming ssh only
iptables -A INPUT -p tcp -s 0/0 -d $SERVER_IP --sport 513:65535 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -s $SERVER_IP -d 0/0 --sport 22 --dport 513:65535 -m state --state ESTABLISHED -j ACCEPT

#allow minecraft
iptables -A INPUT -p tcp --dport 25565 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 25565 -j ACCEPT

# make sure nothing comes or goes out of this box
iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP
