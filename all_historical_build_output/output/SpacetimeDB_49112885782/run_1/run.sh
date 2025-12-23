#!/bin/bash

set -e

# Activate Rust environment
source $HOME/.cargo/env

# Install project dependencies
# Assuming dependencies are managed by Cargo and .NET CLI

# Run cargo tests
cargo test --all || true

# Check that the test outputs are up-to-date
bash tools/check-diff.sh || true

# Ensure C# autogen bindings are up-to-date
cargo run -p spacetimedb-codegen --example regen-csharp-moduledef || true
bash tools/check-diff.sh crates/bindings-csharp || true

# Run C# bindings tests
cd crates/bindings-csharp
dotnet test -warnaserror || true