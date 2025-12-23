#!/bin/bash

# Install project dependencies without skipping any checks
# Removed the -Drat.skip=true option to ensure all checks are performed
mvn clean install -e

# Run tests without skipping any checks
mvn test -e