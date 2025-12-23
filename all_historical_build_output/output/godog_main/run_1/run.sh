#!/bin/bash

set -e

# Run Go tests with godog
go test -v ./...

# Ensure all tests are executed, even if some fail
if [ $? -ne 0 ]; then
    echo "Some tests failed, but continuing execution."
fi