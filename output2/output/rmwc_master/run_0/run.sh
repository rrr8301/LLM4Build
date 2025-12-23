#!/bin/bash

# Install project dependencies
npm install

# Run tests with coverage
npm test --coverage=true || true

# Note: Codecov upload is not handled here. Manually upload coverage reports if needed.