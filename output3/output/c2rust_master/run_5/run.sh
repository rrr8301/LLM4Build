#!/bin/bash

# Activate environment variables
export PATH=$PWD/target/release:$HOME/.local/bin:$PATH

# Run tests
find testsuite -type f -name compile_commands.json -delete
echo "PATH=$PATH"
python3 testsuite/test.py curl json-c lua nginx zstd libxml2 python2 || true