#!bin/bash
tail -n 1000 auth.log | grep -i "failed\|accepted" | awk '{print $(NF-1)}' | sort | uniq -c | sort -nr
