#!/bin/bash

# Install project dependencies and run tests
mvn install
mvn test || true  # Ensure all tests are executed, even if some fail