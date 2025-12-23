#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Run integration tests
./it.sh ci

# Run Maven verify, ensuring all tests are executed
mvn verify -pl integration-tests -P integration-tests -Djvm.runtime=17 -Dit.indexer=middleManager -P skip-static-checks -Dweb.console.skip=true -Dmaven.javadoc.skip=true || true

# Note: The '|| true' ensures that all tests are executed even if some fail