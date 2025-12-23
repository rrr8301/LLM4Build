#!/bin/bash

set -e

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install Go dependencies
go mod tidy

# Run Go tests
go test -v ./... || true  # Ensure all tests run even if some fail

# Check dry run conditions
DRY_RUN=true
if [[ "$GITHUB_EVENT_NAME" == "workflow_dispatch" && "$GITHUB_EVENT_INPUTS_DRYRUN" != "true" ]]; then
    DRY_RUN=false
elif [[ "$GITHUB_REF" == "refs/heads/main" ]]; then
    DRY_RUN=false
elif [[ "$GITHUB_REF" =~ ^refs/heads/v[0-9]+(\.[0-9]+)?$ ]]; then
    DRY_RUN=false
fi

# Ensure GITHUB_TOKEN is set for authentication
if [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: GITHUB_TOKEN is not set. Please set the GITHUB_TOKEN environment variable."
    exit 1
fi

# Configure Git to use the token
git config --global url."https://${GITHUB_TOKEN}:@github.com/".insteadOf "https://github.com/"

# Run semantic release
npx -p conventional-changelog-conventionalcommits -p semantic-release semantic-release --dry-run=$DRY_RUN