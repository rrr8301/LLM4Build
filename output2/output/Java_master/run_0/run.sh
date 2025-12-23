#!/bin/bash

# Activate environment (if any specific activation is needed, otherwise skip)
# No specific environment activation needed for Java

# Install project dependencies and run tests
mvn --batch-mode --update-snapshots verify || true

# Ensure all tests are executed, even if some fail
exit 0