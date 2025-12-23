#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate Python virtual environment
python3.10 -m venv venv
source venv/bin/activate

# Install Python dependencies if any
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
fi

# Print Maven version
mvn -version

# Run Maven tests with detailed output
# Ensure all tests are executed, even if some fail
set +e
mvn -T 4C clean test -e -B -X \
    -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn \
    -DskipTests=false \
    -Denforcer.skip=true \
    -Dlicense.skip=true
TEST_EXIT_CODE=$?
set -e

# Check if there are test failures and print the location of the reports
if [ $TEST_EXIT_CODE -ne 0 ]; then
    echo "There are test failures. Please refer to the test reports in /app/common/target/surefire-reports."
    # Optionally, list the contents of the surefire-reports directory for easier access
    if [ -d "/app/common/target/surefire-reports" ]; then
        ls -l /app/common/target/surefire-reports
        # Print the content of each test report for more detailed information
        for report in /app/common/target/surefire-reports/*.txt; do
            echo "Contents of $report:"
            cat "$report"
        done
    else
        echo "The surefire-reports directory does not exist."
    fi
fi

# Exit with the test exit code
exit $TEST_EXIT_CODE