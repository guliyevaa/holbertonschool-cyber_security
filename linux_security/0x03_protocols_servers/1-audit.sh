#!/bin/bash
awk '!/^#/ && NF {print $1, $2}' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf 2>/dev/null
