#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install project dependencies
npm install

# Run the build process
npm run build

# Start the test server
npm run test:server &

# Wait for the server to start
sleep 5

# Run the test suite
npm run pretest || true
npm run test:unit || true

# Keep the script running to keep the server alive
wait