#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"
export CGO_ENABLED=1

# Start Docker daemon
service docker start

# Check if the 'deps' target exists in the Makefile
if grep -q '^deps:' Makefile; then
    make deps
else
    echo "No 'deps' target found in Makefile. Skipping dependency installation."
fi

# Run functional tests
nohup sudo tcpdump -i lo -w "fvt-kafka-3.9.1.pcap" portrange 29091-29095 >/dev/null 2>&1 &
echo $! >tcpdump.pid

# Run tests and ensure all are executed
set +e
make test_functional TEST_FLAGS="-json" || echo "Functional tests failed."
set -e

# Report test results
if [ -f "_test/fvt.json" ]; then
    go run github.com/mfridman/tparse@v0.16.0 -all -format markdown -file _test/fvt.json
else
    echo "Test results file '_test/fvt.json' not found."
fi

# Stop tcpdump
if [ -f "tcpdump.pid" ]; then sudo kill "$(cat tcpdump.pid)" || true; fi
if [ -f "fvt-kafka-3.9.1.pcap" ]; then sudo chmod a+r "fvt-kafka-3.9.1.pcap"; fi