#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Download drivers
bash scripts/download_driver.sh

# Build and install the project
mvn -B install -DskipTests --no-transfer-progress

# Install browsers using Playwright
mvn exec:java -e -Dexec.mainClass=com.microsoft.playwright.CLI -Dexec.args="install --with-deps" -f playwright/pom.xml --no-transfer-progress

# Run tests with detailed logging
mvn test --no-transfer-progress --fail-at-end -Dorg.slf4j.simpleLogger.showDateTime=true -Dorg.slf4j.simpleLogger.dateTimeFormat=HH:mm:ss -D BROWSER=chromium -D BROWSER_CHANNEL=chrome -e -X