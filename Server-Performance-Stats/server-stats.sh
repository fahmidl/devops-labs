#!/bin/bash

echo "Server Performance Stats"
hostname | awk '{print "Hostname : ",$1}'
uptime

# CPU Usage
echo
top -bn1 | grep "%Cpu" | cut -d ',' -f 4 | awk '{printf "Total CPU usage: %.2f%%\n", 100-$1}'

# Total Memory Usage
echo
free -m | grep "Mem:" | awk '{printf "Total Memory Used : %.2f MiB (%.2f%%)\n", $2-$7, ($2-$7)/$2*100}'
free -m | grep "Mem:" | awk '{printf "Total Memory Free : %.2f MiB (%.2f%%)\n", $7, $7/$2*100}'

# Total Memory Usage
echo
df -m | grep -w "/" | awk '{printf "Total Disk Used : %.2f GiB (%.2f%%) \n", $3/1024, $3/$2*100}'
df -m | grep -w "/" | awk '{printf "Total Disk Free : %.2f GiB (%.2f%%) \n", $4/1024, $4/$2*100}'

# Top 5 processes by CPU usage
echo
echo "Top 5 processes by CPU usage"
ps aux --sort -%cpu | head -6 | awk '{print $1 "\t" $2 "\t" $3 "\t" $11}'

# Top 5 processes by Mem usage
echo
echo "Top 5 processes by Mem usage"
ps aux --sort -%mem | head -6 | awk '{print $1 "\t" $2 "\t" $4 "\t" $11}'
