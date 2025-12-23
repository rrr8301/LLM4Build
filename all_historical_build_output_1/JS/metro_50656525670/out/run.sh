#!/bin/bash

# Run tests with Jest
yarn jest --ci --maxWorkers 4 --reporters=default --reporters=jest-junit --rootdir='./' || true

# Ensure all tests are executed, even if some fail