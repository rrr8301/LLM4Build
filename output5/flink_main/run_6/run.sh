#!/bin/bash

# Install project dependencies, skipping RAT checks
mvn clean install -Drat.skip=true -e

# Run tests without skipping any checks
mvn test -e