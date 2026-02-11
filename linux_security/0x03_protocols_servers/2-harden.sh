#!/bin/bash
find / -type d -perm -0002 2>/dev/null -print -exec chmod o-w {} \;
