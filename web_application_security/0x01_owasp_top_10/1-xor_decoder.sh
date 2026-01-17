#!/bin/bash
# remove {xor}, decode base64, XOR each byte with 0x5A
perl -e 'use MIME::Base64; $s=decode_base64(substr($ARGV[0],5)); print join("", map { chr(ord($_)^0x5A) } split("", $s))' "$1"
