#!/bin/bash

# Navigate to the project directory
cd /app/packages/vuetify

# Run the tests, ensuring all tests are executed even if some fail
pnpm run test --project unit || true