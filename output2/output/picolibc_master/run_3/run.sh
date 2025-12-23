#!/bin/bash

# Activate environment (if any)

# Install project dependencies (if any)

# Run tests
set -e

# Ensure the docker image file exists
if [ ! -f dockerimg-zephyr.tar.zst ]; then
    echo "Error: dockerimg-zephyr.tar.zst not found!"
    exit 1
fi

docker load -i dockerimg-zephyr.tar.zst
docker images -a picolibc

# Run the test suite
docker run -v $(pwd):/picolibc -w /picolibc -v $GITHUB_WORKSPACE/.ccache:/root/.ccache picolibc bash --login -c "ccache --set-config=max_size=450M && ./.github/do-zephyr --buildtype release"

# Ensure all tests are executed
set +e