#!/bin/bash

# Activate any necessary environments (none specified)

# Install project dependencies
npm install

# Run tests and ensure all tests are executed
npm test || true