#!/bin/bash
hashcat -m 0 "$1" /usr/share/wordlists/rockyou.txt --quiet && hashcat -m 0 "$1" --show | awk -F: '{print $2}' > 7-password.txt
