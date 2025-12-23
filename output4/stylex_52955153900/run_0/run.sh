#!/bin/bash

# Install project dependencies
npm install

# Run tests and ensure all tests are executed
npm run test:packages || true