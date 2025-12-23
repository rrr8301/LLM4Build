#!/bin/bash

# Activate environment (if any specific setup is needed, e.g., setting JAVA_HOME)
# Placeholder for activating specific JDK version if needed

# Install project dependencies
mvn clean install

# Run tests, ensuring all tests are executed even if some fail
mvn test --fail-at-end