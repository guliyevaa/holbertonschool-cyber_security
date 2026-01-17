#!/bin/bash
printf "%s" "${1#\{xor\}}" | base64 -d | perl -0777 -pe 's/(.)/chr(ord($1)^90)/ge'
