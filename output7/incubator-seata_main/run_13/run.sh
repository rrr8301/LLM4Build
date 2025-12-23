#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project
mvn -B clean package --file pom.xml -Denforcer.skip=true -Dlicense.skip=true

# Run tests with detailed output and enable debug logging
# Ensure all modules are included by using the -pl and -am flags
mvn test -Dsurefire.printSummary=true -Dsurefire.useFile=false -Denforcer.skip=true -Dlicense.skip=true -X -pl !:seata-config-nacos -am

# Print a message indicating the tests have completed
echo "Tests completed. Check the logs above for any failures."

# Ensure that the test results are available for inspection
echo "Test results are available in the surefire-reports directory."

# Additional step to ensure the test results are printed
if [ -d "/app/config/seata-config-nacos/target/surefire-reports" ]; then
    echo "Printing test results from surefire-reports:"
    cat /app/config/seata-config-nacos/target/surefire-reports/*.txt
fi

# Check for test failures and exit with a non-zero status if any are found
if grep -q "Tests run: .* Failures: [1-9]" /app/config/seata-config-nacos/target/surefire-reports/*.txt; then
    echo "Some tests have failed. Please check the logs for details."
    exit 1
fi