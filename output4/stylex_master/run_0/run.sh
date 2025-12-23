#!/bin/bash

# Install project dependencies
npm install

# Run tests and other scripts
npm run flow || true
npm run test:packages || true
npm run prettier:report || true
npm run lint:report || true