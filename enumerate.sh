#!/bin/bash

# Enumerate IP/OS across a CIDR range.
#
# This script is intended to simplify initial discovery across new networks and provide
# a clean, simple list of host IPs and Operating Systems, where identified.
#
# Usage: ./enumerate <CIDR> <Engagement>

echo "Initiating enumeration... hold tight."
nmap -O $1 -oG $2_raw.txt
echo "Cleaning up the ip results..."
sleep 2
less $2_raw.txt | cut -d" " -f 2 | grep -v Nmap | sort -u | sort > $2_ip.txt
echo "Cleaning up the os results..."
sleep 2
less $2_raw.txt | grep -E '(Host.*OS)' | cut -d":" -f 2,5 | cut -d" " -f 2,4,5 > $2_os.txt
