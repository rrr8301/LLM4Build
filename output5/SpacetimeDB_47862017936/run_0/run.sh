#!/bin/bash

set -e

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
cargo build --locked

# Run tests
set +e
cargo test --all
TEST_RESULT=$?

# Check that the test outputs are up-to-date
bash tools/check-diff.sh

# Ensure C# autogen bindings are up-to-date
cargo run -p spacetimedb-codegen --example regen-csharp-moduledef
bash tools/check-diff.sh crates/bindings-csharp

# Run C# bindings tests
cd crates/bindings-csharp
dotnet test -warnaserror
DOTNET_TEST_RESULT=$?

# Exit with the appropriate status
if [ $TEST_RESULT -ne 0 ] || [ $DOTNET_TEST_RESULT -ne 0 ]; then
  exit 1
fi