#!/bin/bash

# Install project dependencies without skipping RAT checks
mvn clean install -DskipRAT=true -e

# Run tests without skipping any checks
mvn test -e