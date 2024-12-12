#!/bin/bash

################################################
# Script for Deploying Services on GCP
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
    echo "Deploying Frontend on GCP..."

    # Login to Google Container Registry (GCR)
    echo "Configuring Docker for GCP..."
    gcloud auth configure-docker

    # Build and push the Docker image
    echo "Building and pushing the Docker image for frontend..."
    docker build -t frontend ./frontend
    docker tag frontend:latest gcr.io/my-project/frontend:latest
    docker push gcr.io/my-project/frontend:latest

    # Deploy the service
    echo "Deploying frontend to Cloud Run..."
    gcloud run deploy frontend --image gcr.io/my-project/frontend:latest --platform managed --region us-central1
}

# Function to deploy backend
DeployBackend() {
    echo "Deploying Backend on GCP..."

    # Login to Google Container Registry (GCR)
    echo "Configuring Docker for GCP..."
    gcloud auth configure-docker

    # Build and push the Docker image
    echo "Building and pushing the Docker image for backend..."
    docker build -t backend ./backend
    docker tag backend:latest gcr.io/my-project/backend:latest
    docker push gcr.io/my-project/backend:latest

    # Deploy the service
    echo "Deploying backend to Cloud Run..."
    gcloud run deploy backend --image gcr.io/my-project/backend:latest --platform managed --region us-central1
}

# Function to deploy batch
DeployBatch() {
    echo "Deploying Batch Processing on GCP..."
    gcloud dataflow jobs run batch-job --gcs-location gs://my-bucket/templates/batch-template
}

# Function to deploy trigger
DeployTrigger() {
    echo "Deploying Trigger on GCP..."
    gcloud functions deploy trigger-function --runtime python39 --trigger-resource my-bucket \
        --trigger-event google.storage.object.finalize --entry-point trigger_function
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
