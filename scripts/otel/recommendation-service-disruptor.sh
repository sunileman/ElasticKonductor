#!/bin/bash

# Define the container name substring
CONTAINER_NAME_SUBSTRING="recommendation-service"

while true; do
    # Fetch the container ID using docker ps and grep
    CONTAINER_ID=$(sudo docker ps -a --format '{{.ID}}\t{{.Names}}' | grep "$CONTAINER_NAME_SUBSTRING" | cut -f1)

    # If container ID is found, restart it
    if [[ -n "$CONTAINER_ID" ]]; then
        echo "stopping the container with the ID: $CONTAINER_ID."
        sudo docker stop $CONTAINER_ID
    else
        echo "No container with a name containing $CONTAINER_NAME_SUBSTRING found."
    fi

    # Wait for 5 seconds
    echo "sleep 5"
    sleep 5

    # If container ID is found, restart it
    if [[ -n "$CONTAINER_ID" ]]; then
        echo "starting the container with the ID: $CONTAINER_ID."
        sudo docker start $CONTAINER_ID
    else
        echo "No container with a name containing $CONTAINER_NAME_SUBSTRING found."
    fi
done