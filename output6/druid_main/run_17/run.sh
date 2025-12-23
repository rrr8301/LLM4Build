#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Start Docker daemon
dockerd-entrypoint.sh &

# Wait for Docker to start
until docker info >/dev/null 2>&1; do
    sleep 1
done

# Run integration tests
if [ -f "./it.sh" ]; then
    ./it.sh ci
else
    echo "Warning: it.sh not found, skipping integration tests."
fi

# Run Maven verify, ensuring all tests are executed
mvn verify -pl integration-tests -P integration-tests -Djvm.runtime=17 -Dit.indexer=middleManager -Dweb.console.skip=true -Dmaven.javadoc.skip=true -Denforcer.skip=true -Dlicense.skip=true

# Run additional tests if needed
mvn verify -pl benchmarks -P benchmarks -Djvm.runtime=17 -Dit.indexer=middleManager -Dweb.console.skip=true -Dmaven.javadoc.skip=true -Denforcer.skip=true -Dlicense.skip=true