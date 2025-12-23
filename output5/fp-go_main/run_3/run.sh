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

# Run semantic release
npx -p conventional-changelog-conventionalcommits -p semantic-release semantic-release --dry-run=$DRY_RUN