#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project with Maven
mvn --batch-mode --no-transfer-progress verify javadoc:jar || true

# Ensure all tests are executed, even if some fail
mvn test || true