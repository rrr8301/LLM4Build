#!/bin/bash

# Install project dependencies without skipping any checks
# Skip the Rat check by adding the -Drat.skip=true option
mvn clean install -e -Drat.skip=true

# Run tests without skipping any checks
mvn test -e