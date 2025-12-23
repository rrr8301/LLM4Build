#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Build the project
export LLVM_CONFIG_PATH=/usr/bin/llvm-config-18
cargo build --release

# Run tests
find /workspace/testsuite -type f -name compile_commands.json -delete
export PATH=$PWD/target/release:$HOME/.local/bin:$PATH
echo "PATH=$PATH"
python3 /workspace/testsuite/test.py curl json-c lua nginx zstd libxml2 python2 || true