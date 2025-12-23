#!/bin/bash
set -euo pipefail

# Default environment variables (can be overridden)
DO_PUSH=${DO_PUSH:-false}
PREVIEW_LABEL=${PREVIEW_LABEL:-false}
GITHUB_RUN_NUMBER=${GITHUB_RUN_NUMBER:-0}
GITHUB_PR_NUMBER=${GITHUB_PR_NUMBER:-0}

# If preview label is set, set version accordingly
if [ "$PREVIEW_LABEL" = "true" ]; then
  VERSION="0.0.1-PR-${GITHUB_PR_NUMBER}-${GITHUB_RUN_NUMBER}-SNAPSHOT"
  echo "$VERSION" > VERSION
else
  VERSION="1.0.0"  # default version placeholder
fi

echo "Using version: $VERSION"

# If preview, update pom files to new version
if [ "$PREVIEW_LABEL" = "true" ]; then
  echo "Updating Maven pom files to version $VERSION"
  mvn -B versions:set -DnewVersion="$VERSION" -DprocessAllModules=true -DgenerateBackupPoms=false
fi

# Define Maven command based on DO_PUSH
if [ "$DO_PUSH" = "true" ]; then
  MAVEN_COMMAND="deploy"
else
  MAVEN_COMMAND="verify"
fi

echo "Running Maven command: mvn $MAVEN_COMMAND"

# Set Maven options
MAVEN_CLI_OPTS="--show-version --no-transfer-progress --settings settings.xml"

# Set Sonar scanner options (simulate)
JACOCO_REPORT_PATH="$(pwd)/activiti-coverage/target/site/jacoco-aggregate/jacoco.xml"
SONAR_SCANNER_OPTS="sonar:sonar -Dsonar.host.url=https://sonarcloud.io -Dsonar.organization=activiti -Dsonar.projectKey=Activiti_Activiti -Dsonar.coverage.jacoco.xmlReportPaths=${JACOCO_REPORT_PATH}"

# Export environment variables for Maven
export MAVEN_CLI_OPTS
export JACOCO_REPORT_PATH
export SONAR_SCANNER_OPTS

# Run Maven build/test (with placeholders for secrets)
# Secrets like MAVEN_USERNAME, MAVEN_PASSWORD, SONAR_TOKEN can be passed as env vars if needed
mvn $MAVEN_COMMAND $MAVEN_CLI_OPTS $SONAR_SCANNER_OPTS

echo "Maven build/test completed."

# Placeholder for echo-longest-run action
echo "Longest test run: (placeholder) - this would be replaced by a custom action in GitHub Actions."