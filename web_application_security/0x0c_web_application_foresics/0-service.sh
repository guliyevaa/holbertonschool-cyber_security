#!bin/bash
grep -oP 'pam_unix\(\K[^:]+' logs.txt | sort | uniq -c | sort -nr
