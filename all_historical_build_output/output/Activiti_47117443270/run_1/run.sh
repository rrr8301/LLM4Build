#!/bin/bash

# Activate environment variables
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH="$JAVA_HOME/bin:$PATH"

# Install project dependencies and run tests
mvn clean install

# Run Maven commands
mvn deploy --show-version --no-transfer-progress --settings settings.xml
mvn jacoco:merge@merge -N
mvn jacoco:report -Djacoco.dataFile=target/jacoco.exec

# Run SonarCloud analysis if SONAR_TOKEN is set
if [ -n "$SONAR_TOKEN" ]; then
  mvn sonar:sonar -Dsonar.host.url=https://sonarcloud.io \
    -Dsonar.organization=activiti \
    -Dsonar.projectKey=Activiti_Activiti \
    -Dsonar.coverage.jacoco.xmlReportPaths=**/target/site/jacoco*/jacoco.xml \
    --show-version --no-transfer-progress --settings settings.xml
fi

# Configure git user
git config --global user.name "YourGitHubUsername"
git config --global user.email "YourGitHubUsername@users.noreply.github.com"

# Create release tag
VERSION=$(cat VERSION)
git commit -am "Release $VERSION" --allow-empty
git tag -a $VERSION -m "Release version $VERSION"  # Use -a for annotated tag and -m for message

# Push the tag to the remote repository
# Use a personal access token for authentication
if [ -n "$GITHUB_TOKEN" ]; then
  git push -f -q https://YourGitHubUsername:$GITHUB_TOKEN@github.com/YourGitHubUsername/YourRepo.git $VERSION
else
  echo "Error: GITHUB_TOKEN is not set. Cannot push the tag."
  exit 1
fi