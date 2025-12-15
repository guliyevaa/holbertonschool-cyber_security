#!/bin/bash
ps aux -u "$1" -o pid,user,%cpu,%mem,vsz,rss,tty,stat,start,time,cmd --no-headers | grep -v " 0  0 "
