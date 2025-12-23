#!/bin/bash

# Run Maven build
mvn --batch-mode --no-transfer-progress verify javadoc:jar || true

# Ensure all tests are executed, even if some fail
mvn --batch-mode --no-transfer-progress test || true