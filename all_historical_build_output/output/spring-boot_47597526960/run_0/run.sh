#!/bin/bash

# Activate environment (if any specific setup is needed, add here)

# Install project dependencies
# Assuming Gradle is used for building the project
gradle build || true

# Run tests
# Ensure all tests are executed, even if some fail
gradle test --continue || true