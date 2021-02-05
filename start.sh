#!/bin/bash
while :;
do
	cp fng2.log "logs/fng2-$(date +"%d-%m-%y-%r").log"
	./fng2_srv -f fng.cfg
	sleep 1;
done
