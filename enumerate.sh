#!/bin/bash

# Enumerate IP/OS across a CIDR range.
#
# This script is intended to simplify initial discovery across new networks.
#
# Usage: ./enumerate.sh <CIDR> <Engagement>

# Enumerate IPs from limited syn-scan
nmap -Pn -sS $1 -p U:53,67,68,123,161,162,514,T:20,21,22,23,25,80,443,110,135,139,389,445,3389 --open -oG $2_raw
less $2_raw.txt | cut -d" " -f 2 | grep -v Nmap | sort -u | sort > $2_ips

# Enumerate OS and services from IPs
nmap -Pn -A -iL $2_ips --exclude-ports T:113,2000,5060 -oG $2_details # Can only exclude on namap 7.x
