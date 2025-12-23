#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Ensure kubectl is configured to connect to the correct cluster
# This assumes you have a kubeconfig file at /app/config
export KUBECONFIG=/app/config

# Check if the kubeconfig file exists
if [ ! -f "$KUBECONFIG" ]; then
    echo "Kubeconfig file not found at $KUBECONFIG"
    echo "Please ensure the kubeconfig file is available at the specified location."
    echo "You can mount it using the -v option in docker run, e.g., -v /path/to/kubeconfig:/app/config"
    exit 1
fi

# Test connection to the Kubernetes cluster
kubectl cluster-info
if [ $? -ne 0 ]; then
    echo "Failed to connect to the Kubernetes cluster"
    exit 1
fi

# Install project dependencies
go mod tidy

# Run tests
set +e  # Continue on errors
tests/scripts/github-action-helper.sh collect_udev_logs_in_background
export DEVICE_FILTER=$(tests/scripts/github-action-helper.sh find_extra_block_dev)
SKIP_CLEANUP_POLICY=false go test -v -timeout 1800s -failfast -run CephSmokeSuite github.com/rook/rook/tests/integration
TEST_EXIT_CODE=$?

# Collect logs
export LOG_DIR="/app/tests/integration/_output/tests/"
export CLUSTER_NAMESPACE="smoke-ns"
export OPERATOR_NAMESPACE="smoke-ns-system"
tests/scripts/collect-logs.sh

# Note: Artifacts can be manually handled or stored in $LOG_DIR

exit $TEST_EXIT_CODE