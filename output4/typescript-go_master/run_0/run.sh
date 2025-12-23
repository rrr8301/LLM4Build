#!/bin/bash

# Run build
npx hereby build

# Run all tests, ensuring all are executed even if some fail
npx hereby test || true
npx hereby test:benchmarks || true
npx hereby test:tools || true
npx hereby test:api || true

# Placeholder for code coverage (Codecov is not supported in Docker)
# echo "Code coverage would be uploaded here if supported."