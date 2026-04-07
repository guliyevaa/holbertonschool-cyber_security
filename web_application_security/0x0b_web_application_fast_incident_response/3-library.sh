#!/bin/bash
attacker_ip=$(awk '{print $1}' logs.txt | sort | uniq -c | sort -nr | head -n1 | awk '{print $2}')
grep "^$attacker_ip " logs.txt | rev | cut -d'"' -f2 | rev | sort | uniq -c | sort -nr | head -n1 | awk '{print $2}'
