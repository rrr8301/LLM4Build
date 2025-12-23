#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Download drivers
bash scripts/download_driver.sh

# Build and install the project
mvn -B install -D skipTests --no-transfer-progress

# Install browsers using Playwright
mvn exec:java -e -D exec.mainClass=com.microsoft.playwright.CLI -D exec.args="install --with-deps" -f playwright/pom.xml --no-transfer-progress

# Run tests
mvn test --no-transfer-progress --fail-at-end -D org.slf4j.simpleLogger.showDateTime=true -D org.slf4j.simpleLogger.dateTimeFormat=HH:mm:ss -D BROWSER=chromium -D BROWSER_CHANNEL=chrome