#!bin/bash
grep "Accepted" auth.log | awk '{print $NF}' | sort -u | wc -l
