#!/bin/bash
printf "%s" "${1#\{xor\}}" | base64 -d | gawk '{ for(i=1;i<=length;i++) printf "%c", xor(ord(substr($0,i,1)),90) }'
