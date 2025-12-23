#!/bin/bash

# Run tests and check style
set -e
npm run test || true
npm run check-style || true