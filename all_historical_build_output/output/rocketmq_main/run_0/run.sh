#!/bin/bash

# Activate environments (if any specific environment setup is needed, add here)

# Change to the RocketMQ bin directory
cd /app/rocketmq-all-5.3.3-bin-release/bin

# Start NameServer
nohup sh mqnamesrv &

# Start Broker
nohup sh mqbroker -n localhost:9876 &

# Wait for a few seconds to ensure services are up
sleep 10

# Change back to the app directory
cd /app

# Install project dependencies and run tests
# The `-fae` flag in Maven allows the build to continue even if there are test failures
mvn -B package --file pom.xml -DskipTests=false -fae

# Optionally, you can add more commands here if needed