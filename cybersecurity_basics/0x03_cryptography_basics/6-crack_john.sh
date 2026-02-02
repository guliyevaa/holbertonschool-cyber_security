#!/bin/bash
john --wordlist=/usr/share/wordlists/rockyou.txt --format=raw-sha256 "$1" >/dev/null 2>&1 && john --show --format=raw-sha256 "$1" | awk -F: '{print $2}' > 6-password.txt
