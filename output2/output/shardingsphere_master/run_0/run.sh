#!/bin/bash

# Activate environments if needed (none in this case)

# Install project dependencies and build
./mvnw clean install -B -ntp

# Run tests, ensuring all tests are executed even if some fail
set +e
./mvnw test -B -ntp
set -e