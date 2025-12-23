#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"
export GOPATH="/go"

# Install Go dependencies
go mod download

# Check if docker is available and run vector tests if possible
if command -v docker-compose &> /dev/null; then
    docker-compose -f docker/docker-compose-dev.yml run --quiet --rm vector test || true
else
    echo "Docker Compose not found, skipping vector tests"
fi

# Build binary if applicable
if [ "${GITHUB_REF_TYPE}" == "tag" ]; then
    make && ./bin/akvorado version
fi