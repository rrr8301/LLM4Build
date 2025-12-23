#!/bin/bash

# Start MySQL service
service mysql start

# Wait for MySQL to start
until mysqladmin ping --silent; do
    echo "Waiting for MySQL to start..."
    sleep 1
done

# Set MySQL root password and authentication method
MYSQL_ROOT_PASSWORD=rootpassword
mysql --user=root --execute="ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"

# Setup database
mysql --user='root' --password="${MYSQL_ROOT_PASSWORD}" --host='127.0.0.1' -e 'CREATE DATABASE gotest;'

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