#!/bin/bash

set -e

# Activate environment variables if needed
# (No specific environment activation needed for Java)

# Install project dependencies
# (Assuming Maven dependencies are defined in the project)
mvn clean install -Denforcer.skip=true -Dlicense.skip=true

# Run tests
# Ensure all tests are executed, even if some fail
mvn test -Denforcer.skip=true -Dlicense.skip=true