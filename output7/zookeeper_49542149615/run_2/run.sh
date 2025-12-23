#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Show the first log message
git log -n1

# Build with Maven, adding the -X flag for full debug logging
mvn -B -V -e -ntp "-Dstyle.color=always" -Pfull-build verify -Dsurefire-forkcount=1 -Dsurefire.rerunFailingTestsCount=5 -Denforcer.skip=true -Dlicense.skip=true -X

# Note: Removed '|| true' to ensure that the script fails if any test fails.