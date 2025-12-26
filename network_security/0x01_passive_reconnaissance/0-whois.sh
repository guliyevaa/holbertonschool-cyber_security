#!/bin/bash
whois "$DOMAIN" | awk -F > domain.csv
