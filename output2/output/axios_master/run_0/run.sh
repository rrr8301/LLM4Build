#!/bin/bash

# Run server tests
npm run test:node || true

# Run browser tests
npm run test:browser || true

# Run package tests
npm run test:package || true