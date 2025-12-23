#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project
mvn -B clean package --file pom.xml

# Run tests with detailed output and enable debug logging
# Add flags to skip enforcer and license checks if they were previously added
mvn test -Dsurefire.printSummary=true -Dsurefire.useFile=false -Denforcer.skip=true -Dlicense.skip=true -X

# If there are test failures, the script will exit due to 'set -e'
# You can add additional commands here if needed for further diagnostics

# Print a message indicating the tests have completed
echo "Tests completed. Check the logs above for any failures."

# Ensure that the test results are available for inspection
echo "Test results are available in the surefire-reports directory."

# Additional step to ensure the test results are printed
if [ -d "/app/config/seata-config-nacos/target/surefire-reports" ]; then
    echo "Printing test results from surefire-reports:"
    cat /app/config/seata-config-nacos/target/surefire-reports/*.txt
fi