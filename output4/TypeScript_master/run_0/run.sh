#!/bin/bash

# Run tests and ensure all tests are executed even if some fail
set +e
npm run test -- --no-lint --bundle=true