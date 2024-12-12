#!/bin/bash

################################################
# Script for Deploying Services on Azure
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
    echo "Deploying Frontend on Azure..."

    # Login to Azure Container Registry (ACR)
    echo "Logging in to Azure ACR..."
    az acr login --name mycontainerregistry

    # Build and push the Docker image
    echo "Building and pushing the Docker image for frontend..."
    docker build -t frontend ./frontend
    docker tag frontend:latest mycontainerregistry.azurecr.io/frontend:latest
    docker push mycontainerregistry.azurecr.io/frontend:latest

    # Deploy the service
    echo "Creating Azure Web App for frontend..."
    az webapp create --name frontend-app --plan my-app-service-plan --resource-group my-resource-group \
        --deployment-container-image-name mycontainerregistry.azurecr.io/frontend:latest
}

# Function to deploy backend
DeployBackend() {
    echo "Deploying Backend on Azure..."

    # Login to Azure Container Registry (ACR)
    echo "Logging in to Azure ACR..."
    az acr login --name mycontainerregistry

    # Build and push the Docker image
    echo "Building and pushing the Docker image for backend..."
    docker build -t backend ./backend
    docker tag backend:latest mycontainerregistry.azurecr.io/backend:latest
    docker push mycontainerregistry.azurecr.io/backend:latest

    # Deploy the service
    echo "Creating Azure Web App for backend..."
    az webapp create --name backend-app --plan my-app-service-plan --resource-group my-resource-group \
        --deployment-container-image-name mycontainerregistry.azurecr.io/backend:latest
}

# Function to deploy batch
DeployBatch() {
    echo "Deploying Batch Processing on Azure..."
    az batch account create --name batch-account --resource-group my-resource-group --location eastus
}

# Function to deploy trigger
DeployTrigger() {
    echo "Deploying Trigger on Azure..."
    az functionapp create --resource-group my-resource-group --consumption-plan-location eastus \
        --runtime python --runtime-version 3.9 --name trigger-function --storage-account my-storage-account
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
