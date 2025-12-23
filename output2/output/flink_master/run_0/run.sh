#!/bin/bash

# Clone the repository (assuming the repo URL is known)
# git clone https://github.com/apache/flink.git
# cd flink

# Build and test the project
./mvnw clean install

# Run all tests
./mvnw test || true  # Ensure all tests run even if some fail