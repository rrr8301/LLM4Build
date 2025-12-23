#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker to run this script."
    exit 1
fi

# Clean previous results
rm -rf results

# Run tests
./tests/docker/run_tests.sh

# Extract results
results_path="$(pwd)/results/$(readlink results/latest | cut -d'/' -f5)"
success_num=$(jq .num_passed $results_path/report.json)
failure_num=$(jq .num_failed $results_path/report.json)
run_time_secs=$(jq .run_time_seconds $results_path/report.json)

# Show results
echo "success-num=${success_num}"
echo "failure-num=${failure_num}"
echo "run-time-secs=${run_time_secs}"

# Bring down docker containers
./tests/docker/ducker-ak down

# Ensure all test cases are executed, even if some fail
exit 0