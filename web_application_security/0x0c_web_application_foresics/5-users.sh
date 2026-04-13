#!bin/bash
grep -E "useradd|adduser|new user" auth.log | awk '{for(i=1;i<=NF;i++) if($i=="name") print $(i+1)}' | sort -u | paste -sd, -
