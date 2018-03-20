#!/bin/sh
for i in {1..10}; do
	echo $i >> testfile
	sleep 1s
done

