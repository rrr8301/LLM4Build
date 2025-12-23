#!/bin/bash

# Ensure the script is executed from the directory containing the Dockerfile
cd "$(dirname "$0")"

# Build the Docker image
docker build -t your-image-name .

# Run the Docker container
docker run --rm your-image-name