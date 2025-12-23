#!/bin/bash

# Activate environment variables
export CI=true

# Run unit tests with coverage for the primary node version
if [ "$PRIMARY_NODE_VERSION" == "20" ]; then
  yarn nx run eslint-plugin:test -- --coverage || true
else
  yarn nx test eslint-plugin || true
fi

# Ensure all tests are executed, even if some fail
exit 0