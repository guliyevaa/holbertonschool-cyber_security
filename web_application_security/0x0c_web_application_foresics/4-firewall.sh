#!bin/bash
grep -i "iptables\|ufw\|firewall" auth.log | wc -l
