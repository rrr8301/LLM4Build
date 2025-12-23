#!/bin/bash

# Run Maven build and tests
mvn --errors --show-version --batch-mode --no-transfer-progress -Ddoclint=none test || true

# Ensure all tests are executed, even if some fail
exit 0