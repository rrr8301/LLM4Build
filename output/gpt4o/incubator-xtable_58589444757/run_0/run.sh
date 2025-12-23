#!/bin/bash

# Activate any necessary environments (none needed for Java)

# Install project dependencies and build
mvn clean install -ntp -B

# Run tests, ensuring all tests are executed
mvn test || true