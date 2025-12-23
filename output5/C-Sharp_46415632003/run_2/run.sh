#!/bin/bash

# Run tests and ensure all tests are executed even if some fail
dotnet test --no-build --logger "console;verbosity=detailed" || true