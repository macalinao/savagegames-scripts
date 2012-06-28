#!/bin/sh
echo Setting up the firewall...

echo Flushing all rules
iptables -F
iptables -X

echo Setting default filter policy
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

echo Allow unlimited traffic on loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

echo allow http
sudo iptables -A INPUT -p udp -m udp --sport 53 -j ACCEPT
sudo iptables -A INPUT -p tcp -m tcp --sport 80 -j ACCEPT

echo allow inbound
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

echo Allow incoming ssh only
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT

echo allow minecraft
iptables -A INPUT -p tcp --dport 25565 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 25565 -j ACCEPT

echo make sure nothing comes or goes out of this box
iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP
