#!/bin/bash
# Remove {xor}, decode base64, XOR each byte with 0x5A
printf "%s" "${1#\{xor\}}" | base64 -d | perl -lpe '$_=join("", map { chr(ord($_)^0x5A) } split("", $_))'
