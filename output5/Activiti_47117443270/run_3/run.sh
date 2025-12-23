#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Check if VERSION file exists
if [ ! -f VERSION ]; then
  echo "Error: VERSION file not found!"
  exit 1
fi

# Set environment variables
export VERSION=$(cat VERSION)
export JACOCO_REPORT_PATH="/app/activiti-coverage/target/site/jacoco-aggregate/jacoco.xml"
export SONAR_SCANNER_OPTS="sonar:sonar -Dsonar.host.url='https://sonarcloud.io' -Dsonar.organization='activiti' -Dsonar.projectKey='Activiti_Activiti' -Dsonar.coverage.jacoco.xmlReportPaths=${JACOCO_REPORT_PATH}"

# Check if settings.xml exists
if [ ! -f settings.xml ]; then
  echo "Error: settings.xml file not found!"
  exit 1
fi

# Build and test with Maven
mvn deploy --show-version --no-transfer-progress --settings settings.xml

# Configure git user
git config --global user.name "YourGitHubUsername"
git config --global user.email "YourGitHubUsername@users.noreply.github.com"

# Create release tag
git commit -am "Release $VERSION" --allow-empty
git tag -fa $VERSION -m "Release version $VERSION"
git push -f -q origin $VERSION

# Note: The propagation step is skipped as it requires GitHub-specific actions