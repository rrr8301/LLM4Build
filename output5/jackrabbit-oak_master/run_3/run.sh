#!/bin/bash

# Ensure the script is executable
chmod +x /app/run.sh

# Set environment variables based on branch and repository
if [ "$GITHUB_REF" = "refs/heads/trunk" ] && [ "$GITHUB_EVENT_NAME" = "push" ] && [ "$GITHUB_REPOSITORY_OWNER" = "apache" ]; then
    echo 'Running on main branch of the canonical repo'
    MVN_ADDITIONAL_OPTS="-DdeployAtEnd=true"
    MVN_GOAL="deploy"
else
    echo 'Running outside main branch/canonical repo'
    MVN_ADDITIONAL_OPTS=""
    MVN_GOAL="install"
fi

# Run Maven build
mvn -B $MVN_GOAL $MVN_ADDITIONAL_OPTS -Pcoverage,integrationTesting,javadoc -Dnsfixtures=SEGMENT_TAR,DOCUMENT_NS || true

# Note: Upload build result step is not implemented as it is an unsupported GitHub action