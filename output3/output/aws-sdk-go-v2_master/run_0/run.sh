#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Find smithy-go
./ci-find-smithy-go.sh

# Run tests
make ci-test-no-generate || true

# Build and publish smithy-go
make -C $RUNNER_TEMP/smithy-go smithy-publish-local || true

# Cleanup smithy-go
rm -rf $RUNNER_TEMP/smithy-go

# SDK Codegen
make smithy-generate || true