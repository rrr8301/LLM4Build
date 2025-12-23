#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Build the project
export LLVM_CONFIG_PATH=/usr/bin/llvm-config-18
cargo build --release

# Run tests
export PATH=$PWD/target/release:$HOME/.local/bin:$PATH
echo "PATH=$PATH"

# Clone testsuite if not present
if [ ! -d "testsuite" ]; then
    git clone https://github.com/immunant/c2rust-testsuite.git testsuite
    cd testsuite
    git submodule update --init --recursive
    cd ..
fi

# Clean up any existing compile_commands.json files
find testsuite -type f -name compile_commands.json -delete

# Run specific test cases
python3 testsuite/test.py curl json-c lua nginx zstd libxml2 python2 || true