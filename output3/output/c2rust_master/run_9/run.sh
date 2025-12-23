#!/bin/bash

# Activate Rust environment
source $HOME/.cargo/env

# Add Rust components
rustup component add rustfmt-preview rustc-dev

# Set LLVM configuration path
export LLVM_CONFIG_PATH=/usr/bin/llvm-config-15

# Ensure LLVM_LIB_DIR is set
export LLVM_LIB_DIR=$(llvm-config-15 --libdir)

# Build the project
cargo build --release

# Check if testsuite directory exists
if [ ! -d "testsuite" ]; then
    echo "Error: testsuite directory does not exist."
    exit 1
fi

# Run the test suite
find testsuite -type f -name compile_commands.json -delete
export PATH=$PWD/target/release:$HOME/.local/bin:$PATH
echo "PATH=$PATH"
python3 testsuite/test.py curl json-c lua nginx zstd libxml2 python2 || true