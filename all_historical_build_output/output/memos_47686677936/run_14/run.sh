#!/bin/bash

# Run all tests and log the output
go test -v ./... | tee test.log
TEST_EXIT_CODE=${PIPESTATUS[0]}

# Pretty print tests running time
grep --color=never -e '--- PASS:' -e '--- FAIL:' test.log | sed 's/[:()]//g' | awk '{print $2,$3,$4}' | sort -t' ' -nk3 -r | awk '{sum += $3; print $1,$2,$3,sum"s"}'

# Exit with the test exit code
exit $TEST_EXIT_CODE