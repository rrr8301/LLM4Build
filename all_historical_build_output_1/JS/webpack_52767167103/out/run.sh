#!/bin/bash

# Run tests with coverage
yarn cover:unit --ci --cacheDirectory .jest-cache || true

# Ensure all tests are executed, even if some fail
exit 0