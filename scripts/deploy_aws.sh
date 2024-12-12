#!/bin/bash

################################################
# Script for Deploying Services on AWS
################################################

# Function to display help menu
Usage() {
    echo "Usage: $0 [OPTIONS] [-s SERVICE]"
    echo
    echo "Options:"
    echo "  -h|-help     Show this help message and exit"
    echo "  -s SERVICE   Specify the service to deploy (frontend, backend, batch, trigger)"
    echo
    echo "Examples:"
    echo "  $0 -s frontend"
    echo "  $0 -s backend"
    echo "  $0 -s batch"
    echo "  $0 -s trigger"
}

# Function to deploy frontend
DeployFrontend() {
    echo "Deploying Frontend on AWS..."

    # Login to AWS Elastic Container Registry (ECR)
    echo "Logging in to AWS ECR..."
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com

    # Build and push the Docker image
    echo "Building and pushing the Docker image for frontend..."
    docker build -t frontend ./frontend
    docker tag frontend:latest $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/frontend:latest
    docker push $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/frontend:latest

    # Deploy the service
    echo "Creating ECS service for frontend..."
    aws ecs create-service --service-name frontend --cluster my-cluster --task-definition frontend-task
}

# Function to deploy backend
DeployBackend() {
    echo "Deploying Backend on AWS..."

    # Login to AWS Elastic Container Registry (ECR)
    echo "Logging in to AWS ECR..."
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com

    # Build and push the Docker image
    echo "Building and pushing the Docker image for backend..."
    docker build -t backend ./backend
    docker tag backend:latest $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/backend:latest
    docker push $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/backend:latest

    # Deploy the service
    echo "Creating ECS service for backend..."
    aws ecs create-service --service-name backend --cluster my-cluster --task-definition backend-task
}

# Function to deploy batch
DeployBatch() {
    echo "Deploying Batch Processing on AWS..."
    aws batch create-compute-environment --compute-environment-name batch-env --type MANAGED
}

# Function to deploy trigger
DeployTrigger() {
    echo "Deploying Trigger on AWS..."
    aws lambda create-function --function-name trigger-function --runtime python3.9 --handler handler.lambda_handler \
        --role arn:aws:iam::123456789012:role/lambda-role --code S3Bucket=my-bucket,S3Key=trigger-code.zip
}

# Parse named parameters
while getopts "s:h" opt; do
    case ${opt} in
        s ) SERVICE=$OPTARG ;;
        h ) Usage; exit 0 ;;
        \? ) echo "[Error] Invalid parameter"; Usage; exit 1 ;;
    esac
done

# Check if SERVICE is provided
if [ -z "$SERVICE" ]; then
    echo "[Error] -s SERVICE is required."
    Usage
    exit 1
fi

# Execute the corresponding function based on the service
case $SERVICE in
    frontend) DeployFrontend ;;
    backend) DeployBackend ;;
    batch) DeployBatch ;;
    trigger) DeployTrigger ;;
    *) echo "[Error] Invalid service: $SERVICE"; Usage; exit 1 ;;
esac
