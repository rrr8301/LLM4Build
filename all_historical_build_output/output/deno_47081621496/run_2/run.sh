#!/bin/bash

# Activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
# Assuming a requirements.txt or similar file exists
# pip install -r requirements.txt

# Install Node.js dependencies
# Assuming a package.json or similar file exists
# npm install

# Run tests
# Skipping tests that require Docker environment
cargo test --release --locked --features=panic-trace

# Check Deno binary
deno eval "console.log(1+2)" | grep 3