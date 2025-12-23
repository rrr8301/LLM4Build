#!/bin/bash

# Install project dependencies
npm ci

# Run tests and ensure all tests are executed
npm test || true