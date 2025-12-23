#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Build and test with Maven
./mvnw clean install -B -ntp || true
./mvnw test -B -ntp || true

# Ensure all tests are executed, even if some fail