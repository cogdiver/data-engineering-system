#!/bin/bash

################################################
# Script for Starting and Configure Service Local and on Cloud
#
# shell session in the running container.
################################################

# Function to display help menu
Usage() {
    echo "Usage: $0 [OPTIONS] [-e ENVIRONMENT] [-s SERVICE]"
    echo
    echo "Options:"
    echo "  -h|-help    Show this help message and exit"
    echo
    echo "Parameters:"
    echo "  ENVIRONMENT   Deployment environment (local, aws, azure) (default: local)"
    echo "  SERVICE       Service to start and enter (db, app, jupyter)"
    echo
    echo -e "[NOTE] If no ENVIRONMENT is provided, the services will be deploy with local containers."
    echo
    echo " Example:"
    echo "     $0 -s db"
    echo "     $0 -e local -s db"
    echo "     $0 -e aws -s app"
    echo "     $0 -e azure -s db -s app"
}

UpContainer() {
    CONTAINER=des-$1
    docker compose up $CONTAINER -d --build
}

LocalDeployment() {
    echo Starting services locally:

    for service in "${SERVICES[@]}"; do
        echo "  - Starting pentaho-$service..."
        UpContainer $service
    done
}

CloudDeployment() {
    ENVIRONMENT=$1
    echo "Starting services in cloud ($ENVIRONMENT):"

    # Create Infrastructure
    ./scripts/connect.sh -s iac -u "terraform apply"

    # Start services
    for service in "${SERVICES[@]}"; do
        echo "  - Deploying $service"
        ./scripts/service_deploy.sh -e $ENVIRONMENT -s $service -c app
    done
}

# To display current execution parameters
DeployServices() {
    case $ENVIRONMENT in
        local ) LocalDeployment ;;
        aws ) CloudDeployment aws;;
        azure ) CloudDeployment az;;
        \? ) echo '[Invalid parameter]'; Usage; exit 1 ;;
    esac
}

# Define default variables
ENVIRONMENT="local"
SERVICES=()

# Parse named parameters
while getopts "e:s:h" opt; do
    case ${opt} in
        e ) ENVIRONMENT=$OPTARG ;;
        s ) SERVICES+=($OPTARG) ;;
        h ) Usage; exit 0 ;;
        \? ) echo '[Invalid parameter]'; Usage; exit 1 ;;
    esac
done

# Check if SERVICE is provided
if [ -z "$SERVICES" ]; then
    echo "[Error] -s SERVICE is required."
    Usage
    exit 1
fi

# Deploy multiple services
DeployServices
