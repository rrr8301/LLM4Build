#!/bin/bash

# Activate the virtual environment
source /opt/venv/bin/activate

# Stop old running containers
running_containers=$(docker ps -q)
if [[ $running_containers == "" ]]; then
  echo "No running containers"
else
  echo "Running container(s) found"
  docker stop $running_containers
fi
docker container prune -f
docker image prune -af

# Clean repository
find /app/. -name . -o -prune -exec rm -rf -- {} + || true

# Build binary and run tests
CI_DOCKER_BUILD_EXTRA_PARAMS="--build-arg py_major_minor_version=3.12 --build-arg is_nightly=1 --build-arg tf_project_name=tf_nightly_ci" \
./tensorflow/tools/ci_build/ci_build.sh cpu.arm64 bash tensorflow/tools/ci_build/rel/ubuntu/cpu_arm64_test.sh

# Ensure all tests are executed
set +e
# Add any additional test execution commands here
set -e