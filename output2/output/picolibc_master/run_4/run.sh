#!/bin/bash

# Activate environment (if any)

# Install project dependencies (if any)

# Run tests
set -e

# Ensure the docker image file exists
if [ ! -f dockerimg-zephyr.tar.zst ]; then
    echo "Error: dockerimg-zephyr.tar.zst not found!"
    # Attempt to download or generate the docker image file
    echo "Attempting to download or generate dockerimg-zephyr.tar.zst..."
    # Add your logic here to download or generate the file
    # For example, you might download it from a remote server:
    # wget http://example.com/path/to/dockerimg-zephyr.tar.zst -O dockerimg-zephyr.tar.zst
    # Or generate it using a script or command
    # ./generate-docker-image.sh

    # Check again if the file exists after the attempt
    if [ ! -f dockerimg-zephyr.tar.zst ]; then
        echo "Error: dockerimg-zephyr.tar.zst still not found after attempt!"
        exit 1
    fi
fi

docker load -i dockerimg-zephyr.tar.zst
docker images -a picolibc

# Run the test suite
docker run -v $(pwd):/picolibc -w /picolibc -v $GITHUB_WORKSPACE/.ccache:/root/.ccache picolibc bash --login -c "ccache --set-config=max_size=450M && ./.github/do-zephyr --buildtype release"

# Ensure all tests are executed
set +e