#!/bin/bash
awk -v ip=$(awk '{print $1}' logs.txt | sort | uniq -c | sort -nr | head -n1 | awk '{print $2}') '$1==ip {match($0, /"[^"]*"$/, a); print a[0]}' logs.txt | sort | uniq -c | sort -nr | head -n1 | awk '{print $2}'
