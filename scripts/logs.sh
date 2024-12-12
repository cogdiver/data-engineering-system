#!/bin/bash

################################################
# Script for Viewing Logs of a Local Docker Service
#
# This script starts a specified Docker service
# using Docker Compose (if it's not already running)
# and then displays the logs of the running container.
################################################

# Function to display help menu
Usage() {
    echo "Usage: $0 [OPTIONS] [-s SERVICE]"
    echo
    echo "Options:"
    echo "  -h|-help    Show this help message and exit"
    echo
    echo "Parameters:"
    echo "  SERVICE       Service to start and view logs (e.g., db, app, jupyter)"
    echo
    echo " Example:"
    echo "     $0 -s db"
    echo "     $0 -s app"
    echo "     $0 -s jupyter"
}

# Function to start service and view logs
StartAndViewLogs() {
    # Start the service using Docker Compose if not already running
    docker compose up -d des-$SERVICE
    # View the logs of the running service
    docker compose logs -f des-$SERVICE
}

# Define default variables
SERVICE=""

# Parse named parameters
while getopts "s:h" opt; do
    case ${opt} in
        s ) SERVICE=$OPTARG ;;
        h ) Usage; exit 0 ;;
        \? ) echo '[Invalid parameter]'; Usage; exit 1 ;;
    esac
done

# Check if SERVICE is provided
if [ -z "$SERVICE" ]; then
    echo "[Error] -s SERVICE is required."
    Usage
    exit 1
fi

# Start service and view its logs
StartAndViewLogs
