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
    
    # Provide a valid URL for the docker image file
    VALID_URL="http://your-real-url.com/path/to/dockerimg-zephyr.tar.zst"  # Replace with a real URL
    
    # Check if the URL is valid or if the file is available locally
    if [ "$VALID_URL" != "http://your-real-url.com/path/to/dockerimg-zephyr.tar.zst" ]; then
        wget $VALID_URL -O dockerimg-zephyr.tar.zst || {
            echo "Error: Failed to download dockerimg-zephyr.tar.zst from $VALID_URL!"
            exit 1
        }
    else
        echo "Error: No valid URL provided and dockerimg-zephyr.tar.zst is not available locally."
        # Add logic to generate the docker image file if possible
        # Example: ./generate-docker-image.sh
        # Ensure the script to generate the image is available and executable
        if [ -x ./generate-docker-image.sh ]; then
            ./generate-docker-image.sh
        else
            echo "Error: No script available to generate dockerimg-zephyr.tar.zst."
            # Placeholder for generating the docker image
            echo "Generating dockerimg-zephyr.tar.zst..."
            # Add your logic here to generate the docker image
            # For example, you might build the image and save it
            # docker build -t zephyr-image .
            # docker save zephyr-image | zstd -o dockerimg-zephyr.tar.zst
            exit 1
        fi
    fi

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