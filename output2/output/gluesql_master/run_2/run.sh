#!/bin/bash

# Ensure we are in the directory containing the pom.xml
cd /app

# Install project dependencies
mvn install

# Run tests without skipping any
mvn test