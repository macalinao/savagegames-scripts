#!/bin/sh
echo Setting up the firewall...

echo Flushing all rules
iptables -F
iptables -X

echo Setting default filter policy
iptables -t filter -P INPUT DROP 
iptables -t filter -P FORWARD DROP 
iptables -t filter -P OUTPUT DROP

echo Allow unlimited traffic on loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

echo allow http
iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT

echo allow inbound
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

echo Allow incoming ssh only
iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 22 -j ACCEPT

echo allow minecraft
iptables -A INPUT -p tcp --dport 25565 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 25565 -j ACCEPT
