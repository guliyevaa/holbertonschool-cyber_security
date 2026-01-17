#!/bin/bash
# 1-xor_decoder.sh - XOR Decoder for WebSphere (binary-safe)

if [ -z "$1" ]; then
    echo "Usage: $0 {xor}Base64Hash"
    exit 1
fi

# Remove '{xor}' prefix
hash="${1#\{xor\}}"

# XOR key for WebSphere
key=255

# Decode Base64 and XOR in a binary-safe way
echo "$hash" | base64 --decode 2>/dev/null | perl -0777 -pe "s/(.)/chr(ord(\$1)^$key)/ge"
