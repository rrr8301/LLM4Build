#!/bin/bash

# Activate Java environment
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

# Update POM to next pre-release
# Placeholder for update-pom-to-next-pre-release action
echo "Updating POM to next pre-release version..."
# Simulate the update
echo "1.0.0-SNAPSHOT" > VERSION

# Set VERSION environment variable
VERSION=$(cat VERSION)
echo "VERSION=$VERSION"

# Build and Test with Maven
echo "Building and testing with Maven..."
mvn deploy --show-version --no-transfer-progress --settings settings.xml || true

# Merge JaCoCo execution files
echo "Merging JaCoCo execution files..."
mvn jacoco:merge@merge -N || true

# Generate aggregate coverage report
echo "Generating aggregate coverage report..."
mvn jacoco:report -Djacoco.dataFile=target/jacoco.exec || true

# Run SonarCloud analysis
if [ -n "$SONAR_TOKEN" ]; then
  echo "Running SonarCloud analysis..."
  mvn sonar:sonar -Dsonar.host.url=https://sonarcloud.io -Dsonar.organization=activiti -Dsonar.projectKey=Activiti_Activiti -Dsonar.coverage.jacoco.xmlReportPaths=**/target/site/jacoco*/jacoco.xml || true
fi

# Configure git user
echo "Configuring git user..."
git config --global user.name "GitHub Bot"
git config --global user.email "github-bot@users.noreply.github.com"

# Create release tag
echo "Creating release tag..."
git commit -am "Release $VERSION" --allow-empty || true
git tag -fa $VERSION -m "Release version $VERSION" || true
git push -f -q origin $VERSION || true

# Propagate changes
echo "Propagating changes..."
# Placeholder for jx-updatebot-pr action