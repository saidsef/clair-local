#!/bin/bash

JOB="${1:-clair}"

while true
do
    docker logs "$JOB" | grep "update finished" >& /dev/null
    if [ $? == 0 ]; then
        break
    fi

    docker logs "$JOB" | grep "an error occured" >& /dev/null
    if [ $? == 0 ]; then
        echo "Error" >&2
        docker logs "$JOB"
        exit 1
    fi

    echo -n "|"
    sleep 10
done
echo " done .."
