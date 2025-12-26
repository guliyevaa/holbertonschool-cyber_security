#!/bin/bash
subfinder -d "$1" -silent | while read s; do ip=$(dig +short "$s" | head -n1); [ -z "$ip" ] && ip="N/A"; echo "$s,$ip"; done > "$1.txt"
