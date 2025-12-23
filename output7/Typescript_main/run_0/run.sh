#!/bin/bash

# Step 9: Activate environments (if any)

# Step 9: Install project dependencies
npm ci

# Step 9: Run tests
set +e  # Continue executing even if some tests fail
hereby runtests-parallel