#!/bin/bash

echo "Stopping all containers..."

if [ $(docker ps -q) ]
then
    echo "Found and stopped containers.."
    docker stop $(docker ps -q)
    exit 0
else
    echo "No containers found..."
    exit 1
fi