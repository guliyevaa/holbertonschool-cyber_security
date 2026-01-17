#!/bin/bash
# 1-xor_decoder.sh - XOR Decoder for WebSphere

if [ -z "$1" ]; then
    echo "Usage: $0 {xor}Base64Hash"
    exit 1
fi

# Remove '{xor}' prefix
hash="${1#\{xor\}}"

# Base64 decode to raw binary
decoded=$(echo "$hash" | base64 --decode 2>/dev/null)

# XOR key is often 0xFF for WebSphere XOR
key=255

# Binary-safe XOR using perl
echo -n "$decoded" | perl -0777 -pe "s/(.)/chr(ord(\$1)^$key)/ge"
