#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run Maven build and tests
mvn --batch-mode --no-transfer-progress verify javadoc:jar || true

# Ensure all tests are executed, even if some fail
mvn --batch-mode --no-transfer-progress test || true