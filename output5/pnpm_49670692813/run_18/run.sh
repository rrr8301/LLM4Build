#!/bin/bash

# Set the environment variable for pnpm workers
export PNPM_WORKERS=3

# Ensure the pnpm store is set correctly
export PNPM_HOME=/root/.local/share/pnpm
export PATH=$PNPM_HOME:$PATH

# Function to handle errors
handle_error() {
  echo "An error occurred during the execution of the script."
  exit 1
}

# Trap errors
trap 'handle_error' ERR

# Ensure pnpm store is initialized
mkdir -p $PNPM_HOME && pnpm store prune || handle_error

# Check if the node_modules directory exists, if not, install dependencies
if [ ! -d "node_modules" ]; then
  pnpm install --frozen-lockfile --store-dir $PNPM_HOME || handle_error
fi

# Run tests based on the branch
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
if [ "$BRANCH_NAME" == "main" ]; then
  pnpm run test-main || handle_error
else
  pnpm run test-branch || handle_error
fi