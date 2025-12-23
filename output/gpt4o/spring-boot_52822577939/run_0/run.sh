#!/bin/bash

# Activate any necessary environments (none specified)

# Install project dependencies
# Assuming dependencies are managed by Gradle
gradle build

# Run tests
# Ensure all tests are executed, even if some fail
gradle test --continue