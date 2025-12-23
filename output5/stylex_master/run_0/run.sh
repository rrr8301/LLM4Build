#!/bin/bash

# Run npm scripts
set -e
npm run flow || true
npm run test:packages || true
npm run prettier:report || true
npm run lint:report || true