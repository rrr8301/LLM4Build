#!/bin/bash

# Activate environment (if any specific activation is needed, otherwise skip)
# Example: source /path/to/venv/bin/activate

# Install project dependencies
# Assuming Maven handles dependencies, no additional steps needed

# Build and Test
set -e
mvn -B -ff install -pl '!web-console' -Pdist,bundle-contrib-exts -Pskip-static-checks,skip-tests -Dmaven.javadoc.skip=true -T1C || true
mvn verify -pl integration-tests -P int-tests-config-file -DskipTests=false || true

# Ensure all tests are executed, even if some fail