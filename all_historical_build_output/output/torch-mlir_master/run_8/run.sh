#!/bin/bash

set -e
set -o pipefail

# Ensure the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root or use sudo"
    exit 1
fi

# Check if Docker is running by trying to access the Docker socket
if ! docker info > /dev/null 2>&1; then
    echo "Docker does not seem to be running. Please start Docker before running this script."
    echo "You can start Docker with the following command:"
    echo "sudo systemctl start docker"
    exit 1
fi

# Ensure the user has permission to access Docker
if ! groups $USER | grep &>/dev/null '\bdocker\b'; then
    echo "Adding user to the docker group..."
    usermod -aG docker $USER
    echo "Please log out and log back in to apply the group changes."
    exit 1
fi

# Set bazel cache permissions
if [ -d "${HOME}/.cache/bazel" ]; then
    chown -R root:root "${HOME}/.cache/bazel"
fi

# Build docker image
docker build -f utils/bazel/docker/Dockerfile -t torch-mlir:ci .

# Verify buildifier was run (bazel lint)
docker run --rm \
    -v "$(pwd)":"/opt/src/torch-mlir" \
    -v "${HOME}/.cache/bazel":"/root/.cache/bazel" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    torch-mlir:ci \
    bazel run @torch-mlir//:buildifier

if [ -n "$(git status --porcelain)" ]; then
    echo "Please 'bazel run @torch-mlir//:buildifier' and commit changes."
    exit 1
fi

# Bazel build torch-mlir
docker run --rm \
    -v "$(pwd)":"/opt/src/torch-mlir" \
    -v "${HOME}/.cache/bazel":"/root/.cache/bazel" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    torch-mlir:ci \
    bazel build @torch-mlir//:torch-mlir-opt

# Bazel test torch-mlir (lit tests)
docker run --rm \
    -v "$(pwd)":"/opt/src/torch-mlir" \
    -v "${HOME}/.cache/bazel":"/root/.cache/bazel" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    torch-mlir:ci \
    bazel test @torch-mlir//test/...

# Switch bazel cache permissions
if [ -d "${HOME}/.cache/bazel" ]; then
    chown -R "$USER":"$USER" "${HOME}/.cache/bazel"
fi