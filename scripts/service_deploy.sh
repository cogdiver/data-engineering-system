#!/bin/sh

################################################
# Script for Deploying Docker Services to AWS ECS
#
# This script automates the process of building,
# deploying, and running Docker services on AWS ECS.
# It uses AWS ECR for storing Docker images and ECS Fargate
# for running the tasks.
################################################

# Load environment variables
. ./.env

# Function to display help menu
Usage() {
    echo "Usage: $0 [OPTIONS] [-s SERVICE] [-e ENVIRONMENT] [-c CONTEXT] [-r REGION]"
    echo
    echo "Options:"
    echo "  -h|-help    Show this help message and exit"
    echo
    echo "Parameters:"
    echo "  -s SERVICE       Service to deploy (server, client)"
    echo "  -e ENVIRONMENT   Deployment environment (aws, azure)"
    echo "  -c CONTEXT       Build context for Docker (default: current directory)"
    echo "  -r REGION        AWS region (default: us-east-1)"
    echo
    echo -e "\033[1;34m[NOTE] If no parameters are provided, the script will run with default values.\033[0m"
    echo -e "\033[1;34m[NOTE] Parameter -s SERVICE and -e ENVIRONMENT are required.\033[0m"
}

# Function to check if required variables are provided
CheckRequiredVariables() {
    local missing=0

    if [ -z "$SERVICE" ]; then
        missing=1
        echo "[Error] -s SERVICE is required."

    fi

    if [ -z "$ENVIRONMENT" ]; then
        missing=1
        echo "[Error] -e ENVIRONMENT is required."
    fi

    if [ $missing -eq 1 ]; then
        Usage
        exit 1
    fi
}

# to build, deploy and run ECS task
AWS_DeployImage() {
}

# to build, deploy and run ACI service
AZ_DeployImage() {
}

# Define requeried default variables
SERVICE=
ENVIRONMENT=
CONTEXT=.
REGION=us-east-1

# Parse named parameters
while getopts "s:e:c:r:h" opt; do
    case ${opt} in
        s ) SERVICE=$OPTARG ;;
        e ) ENVIRONMENT=$OPTARG ;;
        c ) CONTEXT=$OPTARG ;;
        r ) REGION=$OPTARG ;;
        h ) Usage; exit 0 ;;
        \? ) echo '[Invalid parameter]'; Usage; exit 1 ;;
    esac
done

# Check if required variables are provided
CheckRequiredVariables

# Check if ENVIRONMENT variable is valid
case "$ENVIRONMENT" in
    aws) AWS_DeployImage ;;
    azure) AZ_DeployImage ;;
    *) echo -e "[ERROR] ENVIRONMENT parameter can only be 'aws' or 'azure'"; Usage; exit 1 ;;
esac
