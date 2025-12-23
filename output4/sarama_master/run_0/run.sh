#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Install project dependencies
make deps

# Run functional tests
nohup sudo tcpdump -i lo -w "fvt-kafka-3.9.1.pcap" portrange 29091-29095 >/dev/null 2>&1 &
echo $! >tcpdump.pid

# Run tests and ensure all are executed
set +e
make test_functional
set -e

# Report test results
go run github.com/mfridman/tparse@v0.18.0 -all -format markdown -file _test/fvt.json

# Stop tcpdump
if [ -f "tcpdump.pid" ]; then sudo kill "$(cat tcpdump.pid)" || true; fi
if [ -f "fvt-kafka-3.9.1.pcap" ]; then sudo chmod a+r "fvt-kafka-3.9.1.pcap"; fi