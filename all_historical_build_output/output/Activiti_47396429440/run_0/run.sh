#!/bin/bash

# Activate environment variables
export MAVEN_CLI_OPTS="--show-version --no-transfer-progress --settings settings.xml"
export MAVEN_USERNAME="<your-nexus-username>"
export MAVEN_PASSWORD="<your-nexus-password>"
export SONAR_TOKEN="<your-sonar-token>"

# Set Java version
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64

# Set preview version if applicable
if [[ "$GITHUB_EVENT_LABELS" == *"preview"* ]]; then
  GITHUB_PR_NUMBER="PR-<your-pr-number>"
  echo "0.0.1-${GITHUB_PR_NUMBER}-${GITHUB_RUN_NUMBER}-SNAPSHOT" > VERSION
  VERSION=$(cat VERSION)
  mvn -B versions:set -DnewVersion=$VERSION -DprocessAllModules=true -DgenerateBackupPoms=false
fi

# Define Maven command
if [[ "$DO_PUSH" == "true" ]]; then
  MAVEN_COMMAND="deploy"
else
  MAVEN_COMMAND="install"
fi

# Build and test with Maven
mvn $MAVEN_COMMAND $MAVEN_CLI_OPTS || true

# Merge JaCoCo execution files
mvn jacoco:merge@merge -N || true

# Generate aggregate coverage report
mvn jacoco:report -Djacoco.dataFile=target/jacoco.exec || true

# Run SonarCloud analysis if token is available
if [[ -n "$SONAR_TOKEN" ]]; then
  export SONAR_SCANNER_OPTS="sonar:sonar -Dsonar.host.url=https://sonarcloud.io -Dsonar.organization=activiti -Dsonar.projectKey=Activiti_Activiti -Dsonar.coverage.jacoco.xmlReportPaths=**/target/site/jacoco*/jacoco.xml"
  mvn $SONAR_SCANNER_OPTS $MAVEN_CLI_OPTS || true
fi