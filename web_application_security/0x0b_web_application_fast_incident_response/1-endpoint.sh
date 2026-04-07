#!/bin/bash

# Extract requested URLs, count them, sort, and print the most frequent one
awk -F'"' '{print $2}' logs.txt | awk '{print $2}' | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}'
