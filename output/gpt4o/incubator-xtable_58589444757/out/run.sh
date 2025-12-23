#!/bin/bash

# Build with RAT check skipped and run all tests
mvn clean install -ntp -B -Drat.skip=true
mvn test -B -Drat.skip=true