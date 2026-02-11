#!/bin/bash
find / -type d -perm -0002 2>/dev/null -exec echo {} \; -exec chmod o-w {} \;
