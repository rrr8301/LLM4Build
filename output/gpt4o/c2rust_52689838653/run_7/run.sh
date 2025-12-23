#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Build the project
export LLVM_CONFIG_PATH=/usr/bin/llvm-config-18
cd /workspace/c2rust
cargo build --release

# Run tests
export PATH=/workspace/c2rust/target/release:$HOME/.local/bin:$PATH
echo "PATH=$PATH"

# Clean up any existing compile_commands.json files
find /workspace/testsuite -type f -name compile_commands.json -delete

# Run specific test cases
cd /workspace/testsuite
python3 test.py curl json-c lua nginx zstd libxml2 python2 || true