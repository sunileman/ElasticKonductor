#!/bin/bash
##this script is built to either start or stop the otel demo 
# load gen process. by default otel starts the load gen process.
# For demo purposes, we may want to stop it.
# The script accepts start or stop

# Define the container name substring
CONTAINER_NAME_SUBSTRING="load-generator"

# Fetch the container ID using docker ps and grep
CONTAINER_ID=$(sudo docker ps -a --format '{{.ID}}\t{{.Names}}' | grep "$CONTAINER_NAME_SUBSTRING" | cut -f1)

if [[ $# -eq 0 ]]; then
    echo "No argument provided. Please specify 'start' or 'stop'."
    exit 1
fi

if [[ "$1" == "start" ]]; then
    # Start the container
    if [[ -n "$CONTAINER_ID" ]]; then
        echo "Starting the container with the ID: $CONTAINER_ID."
        sudo docker start $CONTAINER_ID
    else
        echo "No container with a name containing $CONTAINER_NAME_SUBSTRING found."
    fi
elif [[ "$1" == "stop" ]]; then
    # Stop the container
    if [[ -n "$CONTAINER_ID" ]]; then
        echo "Stopping the container with the ID: $CONTAINER_ID."
        sudo docker stop $CONTAINER_ID
    else
        echo "No container with a name containing $CONTAINER_NAME_SUBSTRING found."
    fi
else
    echo "Invalid argument. Please specify 'start' or 'stop'."
    exit 1
fi
