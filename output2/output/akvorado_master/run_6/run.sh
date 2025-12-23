#!/bin/bash

# Ensure the script is executed from the directory containing the Dockerfile
cd "$(dirname "$0")"

# Check if package.json exists in the current directory
if [ ! -f package.json ]; then
  echo "Error: package.json not found in the current directory."
  exit 1
fi

# Build the Docker image
docker build -t your-image-name .

# Run the Docker container
docker run --rm your-image-name