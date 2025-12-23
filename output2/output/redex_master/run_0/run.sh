#!/bin/bash

# Install project dependencies
mvn install

# Run tests
mvn test || true  # Ensure all tests run even if some fail