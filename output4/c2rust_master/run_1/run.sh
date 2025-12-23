#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Set PATH for the built binaries
export PATH=$PWD/target/release:$HOME/.local/bin:$PATH

# Run tests
find testsuite -type f -name compile_commands.json -delete
python3 testsuite/test.py curl json-c lua nginx zstd libxml2 python2 || true