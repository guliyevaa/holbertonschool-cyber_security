#!bin/bash
grep "sshd.*Accepted password" auth.log | awk '{print $(NF-3)}' | sort -u | wc -l
