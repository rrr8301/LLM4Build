#!/bin/bash

# Run the Deno server script
# Ensure all tests are executed, even if some fail
set -e
trap 'echo "An error occurred. Continuing with the next command."' ERR

# Check if server.ts exists before running
if [ ! -f /app/server.ts ]; then
  echo "server.ts not found in /app directory."
  exit 1
fi

# Run the Deno server
deno run --allow-net /app/server.ts