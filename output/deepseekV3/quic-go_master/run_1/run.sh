#!/bin/bash

# Set up Docker Buildx
docker buildx create --use

# Set tag name
if [[ $GITHUB_REF == refs/tags/* ]]; then
    TAG=${GITHUB_REF#refs/tags/}
else
    TAG=latest
fi

# Build the Docker image
docker buildx build \
    --platform linux/amd64,linux/arm64 \
    -f interop/Dockerfile \
    -t martenseemann/quic-go-interop:$TAG \
    .

# Push the image if this is a push event (not a PR)
if [ "$GITHUB_EVENT_NAME" == "push" ]; then
    docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
    docker buildx build \
        --platform linux/amd64,linux/arm64 \
        -f interop/Dockerfile \
        -t martenseemann/quic-go-interop:$TAG \
        --push \
        .
fi