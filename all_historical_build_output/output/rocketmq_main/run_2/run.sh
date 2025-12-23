#!/bin/bash

# Function to check if a service is running
check_service() {
    local service_name=$1
    local port=$2
    for i in {1..10}; do
        if nc -z localhost $port; then
            echo "$service_name is running on port $port"
            return 0
        fi
        echo "Waiting for $service_name to start..."
        sleep 5
    done
    echo "Error: $service_name did not start."
    exit 1
}

# Change to the RocketMQ bin directory
cd /app/rocketmq-all-5.3.3-bin-release/bin

# Start NameServer
nohup sh mqnamesrv &

# Check if NameServer is running
check_service "NameServer" 9876

# Start Broker
nohup sh mqbroker -n localhost:9876 &

# Check if Broker is running
check_service "Broker" 10911

# Change back to the app directory
cd /app

# Install project dependencies and run tests
mvn -B package --file pom.xml

# Optionally, you can add more commands here if needed