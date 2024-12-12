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
        echo "  - Starting des-$service..."
        UpContainer $service
    done
}

CloudDeployment() {
    ENVIRON=$1
    echo "Starting services in cloud ($ENVIRON):"
    echo "TF_VAR_deploy_${ENVIRON}=true" >> env/.env.iac

    # Create Infrastructure
    # ./scripts/connect.sh -s iac -u "terraform init && terraform apply --auto-approve"

    # Start services
    for service in "${SERVICES[@]}"; do
        echo "  - Deploying $service in $ENVIRON..."
        # ./scripts/service_deploy.sh -e $ENVIRON -s $service -c app/$service
    done
}

# To display current execution parameters
DeployServices() {
    echo "######################################" > env/.env.iac
    echo "### Flag Variables" >> env/.env.iac
    echo "######################################" >> env/.env.iac

    for ENVIRON in "${ENVIRONMENTS[@]}"; do
        case $ENVIRON in
            local ) LocalDeployment ;;
            aws ) CloudDeployment aws;;
            azure ) CloudDeployment az;;
            gcp ) CloudDeployment gcp;;
            \? ) echo '[Invalid parameter]'; Usage; exit 1 ;;
        esac
    done
}

# Define default variables
ENVIRONMENTS=()
SERVICES=()

# Parse named parameters
while getopts "e:s:h" opt; do
    case ${opt} in
        e ) ENVIRONMENTS+=($OPTARG) ;;
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
