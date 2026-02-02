#!/bin/bash
hashcat -m 0 -a 1 "$1" wordlist1.txt wordlist2.txt --quiet && hashcat -m 0 "$1" --show | awk -F: '{print $2}' > 9-password.txt
