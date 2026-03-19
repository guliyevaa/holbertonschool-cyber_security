#!/bin/bash
sudo nmap -sM -p ftp,ssh,telnet,http,https -v "$1"
