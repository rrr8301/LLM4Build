#!/bin/bash

# Step 9: Activate environments
# No specific environment activation needed for Node.js

# Step 9: Install project dependencies
npm install

# Step 9: Run tests
# Ensure all tests are executed, even if some fail
npm test || true