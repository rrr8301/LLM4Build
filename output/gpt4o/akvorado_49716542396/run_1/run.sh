#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"
export GOPATH="/go"

# Install Go dependencies
go mod download

# Run vector tests
docker compose -f docker/docker-compose-dev.yml run --quiet --rm vector test || true

# Build binary if applicable
if [ "${GITHUB_REF_TYPE}" == "tag" ]; then
    make && ./bin/akvorado version
fi