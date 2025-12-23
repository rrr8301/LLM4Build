#!/bin/bash

# Activate environments (if any)

# Docker login
echo "Logging into DockerHub"
echo "${DOCKERHUB_TOKEN}" | docker login -u "${DOCKERHUB_USER}" --password-stdin

# Build and push Docker images
echo "Building and pushing Docker images"
docker build -t "${DOCKERHUB_OWNER}/devlake:amd64-builder" --target builder ./backend
docker push "${DOCKERHUB_OWNER}/devlake:amd64-builder"

# Get short SHA
SHORT_SHA=$(git rev-parse --short HEAD)
echo "SHORT_SHA=${SHORT_SHA}"

# Build Python
echo "Building Python"
cd backend
make build-python

# Run unit tests
echo "Running unit tests"
go version
cp env.example .env
make unit-test

# Run MySQL tests
echo "Running MySQL tests"
export DB_URL="mysql://root:root@db:3306/lake?charset=utf8mb4&parseTime=True"
export E2E_DB_URL="mysql://root:root@db:3306/lake?charset=utf8mb4&parseTime=True"
make e2e-test-go-plugins
make e2e-test

# Generate mock
echo "Generating mock"
make mock

# Run golangci-lint
echo "Running golangci-lint"
golangci-lint run --config .golangci.yaml

# Ensure all tests are executed
echo "All tests executed"