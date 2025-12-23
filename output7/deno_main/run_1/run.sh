#!/bin/bash

# Run the Deno server script
# Ensure all tests are executed, even if some fail
set -e
trap 'echo "An error occurred. Continuing with the next command."' ERR

# Run the Deno server
deno run --allow-net server.ts