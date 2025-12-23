#!/bin/bash

# Start MySQL service
service mysql start

# Wait for MySQL to start
until mysqladmin ping --silent; do
    echo "Waiting for MySQL to start..."
    sleep 1
done

# Setup database
mysql --user 'root' --host '127.0.0.1' -e 'create database gotest;'

# Install Go dependencies
go mod tidy

# Run tests
set +e  # Continue on error
go test -v '-race' '-covermode=atomic' '-coverprofile=coverage.out' -parallel 10
set -e

# Run benchmarks
go test -run '^$' -bench .

# Placeholder for sending coverage
echo "Coverage report would be sent here."

# Keep the container running
tail -f /dev/null