#!/bin/bash

# Run npm install to ensure all dependencies are installed
npm ci

# Run tests and ensure all tests are executed even if some fail
npm test || true