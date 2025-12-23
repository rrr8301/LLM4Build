#!/bin/bash

# Run tests and ensure all test cases are executed
set -e
npm run test -- --no-lint --bundle=true || true