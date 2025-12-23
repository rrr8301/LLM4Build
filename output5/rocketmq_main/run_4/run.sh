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
        echo "Waiting for $service_name to start on port $port..."
        sleep 5
    done
    echo "Error: $service_name did not start on port $port."
    exit 1
}

# Change to the RocketMQ bin directory
cd /app/rocketmq-all-5.3.3-bin-release/bin

# Start NameServer
echo "Starting NameServer..."
nohup sh mqnamesrv > /dev/null 2>&1 &
check_service "NameServer" 9876

# Start Broker
echo "Starting Broker..."
nohup sh mqbroker -n localhost:9876 > /dev/null 2>&1 &
check_service "Broker" 10911

# Change back to the app directory
cd /app

# Ensure the pom.xml file exists
if [ ! -f pom.xml ]; then
    echo "Error: pom.xml not found in /app"
    exit 1
fi

# Install project dependencies and run tests
echo "Running Maven build and tests..."
mvn -B package --file pom.xml -DskipTests=false

# If there are test failures, print the test results
if [ $? -ne 0 ]; then
    echo "Tests failed. Check the test reports for details."
    if [ -d /app/client/target/surefire-reports ]; then
        cat /app/client/target/surefire-reports/*.txt
    else
        echo "No test reports found."
    fi
    exit 1
fi

echo "All tests passed successfully."