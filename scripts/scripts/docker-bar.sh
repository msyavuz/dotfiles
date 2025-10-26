#!/usr/bin/env bash

# Total and running containers
running=$(docker ps -q | wc -l)
total=$(docker ps -a -q | wc -l)

# Gather info for alt text (name + uptime)
alt=$(docker ps --format '{{.Names}} up {{.RunningFor}}' | sed ':a;N;$!ba;s/\n/\\n/g')

# Output JSON
printf '{"text": "%s/%s", "tooltip": "%s"}\n' "$running" "$total" "$alt"
