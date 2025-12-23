#!/bin/bash

# Build with Maven, skipping RAT check for Dockerfile and run.sh
mvn --errors --show-version --batch-mode --no-transfer-progress -Ddoclint=all \
    -Drat.skip=true

# Run tests (don't skip on failure)
mvn test