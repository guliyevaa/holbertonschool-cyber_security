#!/bin/bash
# XOR Decoder Script for WebSphere
# Usage: ./1-xor_decoder.sh {xor}Base64Hash

if [ -z "$1" ]; then
    echo "Usage: $0 {xor}Base64Hash"
    exit 1
fi

# Remove the '{xor}' prefix
hash="${1#\{xor\}}"

# Base64 decode
decoded=$(echo "$hash" | base64 --decode 2>/dev/null)

# XOR key (common single-character key; adjust if different)
key=42  # Example: 42 is '*', but change if needed

# XOR decode function
xor_decode() {
    input="$1"
    output=""
    for ((i=0; i<${#input}; i++)); do
        char="${input:$i:1}"
        # Get ASCII of char, XOR with key, convert back to char
        ascii=$(printf "%d" "'$char")
        xor_char=$((ascii ^ key))
        output+=$(printf "\\x%x" "$xor_char")
    done
    echo -e "$output"
}

# Print the decoded text
xor_decode "$decoded"
