#!/bin/bash

set -e
set -o pipefail

# Set bazel cache permissions
if [ -d "${HOME}/.cache/bazel" ]; then
    sudo chown -R root:root "${HOME}/.cache/bazel"
fi

# Build docker image
docker build -f utils/bazel/docker/Dockerfile -t torch-mlir:ci .

# Verify buildifier was run (bazel lint)
docker run --rm \
    -v "$(pwd)":"/opt/src/torch-mlir" \
    -v "${HOME}/.cache/bazel":"/root/.cache/bazel" \
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
    torch-mlir:ci \
    bazel build @torch-mlir//:torch-mlir-opt

# Bazel test torch-mlir (lit tests)
docker run --rm \
    -v "$(pwd)":"/opt/src/torch-mlir" \
    -v "${HOME}/.cache/bazel":"/root/.cache/bazel" \
    torch-mlir:ci \
    bazel test @torch-mlir//test/...

# Switch bazel cache permissions
if [ -d "${HOME}/.cache/bazel" ]; then
    sudo chown -R "$USER":"$USER" "${HOME}/.cache/bazel"
fi