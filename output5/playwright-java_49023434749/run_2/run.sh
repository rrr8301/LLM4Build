#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate environment variables if any (none in this case)

# Download drivers
bash scripts/download_driver.sh

# Build & Install without tests
mvn -B install -DskipTests --no-transfer-progress

# Install browsers using Playwright
mvn exec:java -e -Dexec.mainClass=com.microsoft.playwright.CLI -Dexec.args="install --with-deps" -f playwright/pom.xml --no-transfer-progress

# Run tests, ensuring all tests are executed even if some fail
mvn test --no-transfer-progress --fail-at-end -Dorg.slf4j.simpleLogger.showDateTime=true -Dorg.slf4j.simpleLogger.dateTimeFormat=HH:mm:ss

# Check if there are any test failures
if [ $? -ne 0 ]; then
    echo "Tests failed. Check the surefire-reports for details."
    exit 1
fi