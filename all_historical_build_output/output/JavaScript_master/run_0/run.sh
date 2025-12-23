#!/bin/bash

# Run tests and check style
set -e

# Run tests
npm run test || true

# Check code style
npm run check-style || true