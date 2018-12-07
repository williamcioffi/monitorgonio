#!/bin/sh
while IFS='' read -r line || [[ -n "$line" ]]; do
	echo $line >> gonio_sim_log.txt
	sleep 1s
done < "$1"
