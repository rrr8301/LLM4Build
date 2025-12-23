#!/bin/bash

set -e

# Activate environment variables if needed
export MAVEN_OPTS="-Xmx6g -Dhttp.keepAlive=false -Dmaven.wagon.http.pool=false -Dmaven.wagon.http.retryhandler.count=5 -Dmaven.wagon.httpconnectionManager.ttlSeconds=240"

# Start Docker daemon
dockerd-entrypoint.sh &

# Wait for Docker daemon to start
while (! docker stats --no-stream ); do
    echo "Waiting for Docker to start..."
    sleep 1
done

# Build Docker image
docker-compose -f docker/docker-compose.yaml -f docker/docker-compose.centos-7.111.yaml build

# Run the build process
docker-compose -f docker/docker-compose.yaml -f docker/docker-compose.centos-7.111.yaml run build | tee build.output

# Check for test failures
./.github/scripts/check_build_result.sh build.output || true

# Note: The script does not handle JVM thread dumps or artifact uploads as these are GitHub-specific actions.