#!/bin/bash

# Enable full backtrace for Rust errors
export RUST_BACKTRACE=full

# Function to run command with error checking
run_command() {
    echo "Running: $@"
    "$@"
    local status=$?
    if [ $status -ne 0 ]; then
        echo "Error: Command failed with exit status $status"
        return $status
    fi
    return 0
}

# Run clippy
run_command cargo clippy --workspace --all-targets --exclude rustpython_wasm --exclude rustpython-compiler-source -- -Dwarnings

# Run tests
run_command cargo test --workspace --exclude rustpython_wasm --exclude rustpython-compiler-source --verbose --features threading

# Check compilation without threading
run_command cargo check

# Test example projects
cd /usr/src/rustpython
if [ -f example_projects/barebone/Cargo.toml ]; then
    run_command cargo run --manifest-path example_projects/barebone/Cargo.toml
else
    echo "Warning: barebone example not found"
fi

if [ -f example_projects/frozen_stdlib/Cargo.toml ]; then
    run_command cargo run --manifest-path example_projects/frozen_stdlib/Cargo.toml
else
    echo "Warning: frozen_stdlib example not found"
fi

# Run VM tests separately with Python compilation disabled
cd /usr/src/rustpython/crates/vm
run_command RUSTPYTHON_SKIP_PYTHON_COMPILE=1 cargo test --verbose

# Additional checks for Lib directory structure
echo "Verifying Lib directory structure..."
[ -d /usr/src/rustpython/Lib ] && echo "Lib directory exists" || echo "Lib directory missing"
[ -d /usr/src/rustpython/Lib/python_builtins ] && echo "python_builtins exists" || echo "python_builtins missing"
[ -d /usr/src/rustpython/Lib/core_modules ] && echo "core_modules exists" || echo "core_modules missing"

# Verify Python files are readable
echo "Verifying Python files are readable..."
find /usr/src/rustpython/Lib -name "*.py" -exec test -r {} \; -exec echo "{} is readable" \; || echo "Some Python files are not readable"

echo "All test steps completed"