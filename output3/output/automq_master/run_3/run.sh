#!/bin/bash

# Activate SDKMAN
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Set environment variables
export ESK_TEST_YML="tests/suites/main_kos_test_suite1.yml"
export _DUCKTAPE_OPTIONS="--deflake 4"

# Install project dependencies
gradle build --warning-mode all

# Run E2E tests
./tests/docker/run_tests.sh

# Extract results
results_path="$(pwd)/results/$(readlink results/latest | cut -d'/' -f5)"
if [ -f "$results_path/report.json" ]; then
    success_num=$(jq .num_passed $results_path/report.json)
    failure_num=$(jq .num_failed $results_path/report.json)
    run_time_secs=$(jq .run_time_seconds $results_path/report.json)
else
    echo "Error: report.json not found."
    success_num=0
    failure_num=0
    run_time_secs=0
fi

# Show results
echo "success-num=$success_num"
echo "failure-num=$failure_num"
echo "run-time-secs=$run_time_secs"

# Bring down docker containers
./tests/docker/ducker-ak down || true

# Ensure all tests are executed
exit 0