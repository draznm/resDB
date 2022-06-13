#!/bin/bash
USERNAME=tmane002
HOSTS="$1"
SCRIPT="$2"
count=0
for HOSTNAME in ${HOSTS}; do
    echo " "
	echo "Inside vcloud_cmd: " 
	echo " "
	echo "ssh -n -o BatchMode=yes -o StrictHostKeyChecking=no -l ${USERNAME} ${HOSTNAME} "${SCRIPT}" &"
	ssh -n -o BatchMode=yes -o StrictHostKeyChecking=no -l ${USERNAME} ${HOSTNAME} "${SCRIPT}" &
	count=`expr $count + 1`
done

while [ $count -gt 0 ]; do
	wait $pids
	count=`expr $count - 1`
done
