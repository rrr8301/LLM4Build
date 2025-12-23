#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install Go dependencies
go mod download

# Run tests
set +e  # Continue execution even if some tests fail
tests/scripts/github-action-helper.sh collect_udev_logs_in_background
export DEVICE_FILTER=$(tests/scripts/github-action-helper.sh find_extra_block_dev)
SKIP_CLEANUP_POLICY=false go test -v -timeout 1800s -failfast -run CephSmokeSuite github.com/rook/rook/tests/integration

# Collect logs
export LOG_DIR="/app/tests/integration/_output/tests/"
export CLUSTER_NAMESPACE="smoke-ns"
export OPERATOR_NAMESPACE="smoke-ns-system"
tests/scripts/collect-logs.sh

# Note: Artifact upload is not handled in this script