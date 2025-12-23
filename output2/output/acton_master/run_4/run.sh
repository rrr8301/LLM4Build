#!/bin/bash

# Source ghcup environment
source /root/.ghcup/env

# Build Acton
make -j2 -C /app

# Run tests
make -C /app test