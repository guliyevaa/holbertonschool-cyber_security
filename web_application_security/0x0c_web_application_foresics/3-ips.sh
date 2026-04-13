#!bin/bash
grep "Accepted" auth.log | awk '{print $(NF-3)}' | sort -u | wc -l
