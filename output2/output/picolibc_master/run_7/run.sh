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
    
    # Replace with a valid URL or ensure the file is available locally
    VALID_URL="http://your-valid-url.com/path/to/dockerimg-zephyr.tar.zst"
    
    # Example logic to download the file
    wget $VALID_URL -O dockerimg-zephyr.tar.zst || {
        echo "Error: Failed to download dockerimg-zephyr.tar.zst!"
        exit 1
    }

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