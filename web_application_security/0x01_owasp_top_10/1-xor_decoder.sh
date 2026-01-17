#!/bin/bash
# XOR Decoder for WebSphere (robust version)

if [ -z "$1" ]; then
    echo "Usage: $0 {xor}Base64Hash"
    exit 1
fi

# Remove '{xor}' prefix
hash="${1#\{xor\}}"

# Base64 decode to raw bytes
decoded=$(echo "$hash" | base64 --decode 2>/dev/null)

# XOR key (WebSphere often uses 0xFF for XOR)
key=255  # Adjust if needed

# Use a binary-safe XOR loop
printf "%s" "$decoded" | perl -pe "s/(.)/chr(ord(\$1)^$key)/ge"
