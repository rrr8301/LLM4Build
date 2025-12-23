#!/usr/bin/env bash
set -euo pipefail

# Configure git
git config --global core.symlinks true
git config --global fetch.parallel 32

# Clone submodules
git submodule update --init --recursive --depth=1 -- ./tests/util/std

# Clone wpt suite if WPT enabled (set env WPT=1 to enable)
if [[ "${WPT:-0}" == "1" ]]; then
  git submodule update --init --recursive --depth=1 -- ./tests/wpt/suite
fi

# Clone node_compat suite if job is test (assume always test here)
git submodule update --init --recursive --depth=1 -- ./tests/node_compat/runner/suite

# Setup incremental LTO and sysroot build

echo "Setting up sysroot and incremental LTO build..."

# Remove man-db to avoid triggers (simulate)
apt-get remove --purge -y man-db || true

# Remove older clang versions (simulate)
apt-get remove -y 'clang-12*' 'clang-13*' 'clang-14*' 'clang-15*' 'clang-16*' 'clang-17*' 'clang-18*' 'llvm-12*' 'llvm-13*' 'llvm-14*' 'llvm-15*' 'llvm-16*' 'llvm-17*' 'llvm-18*' 'lld-12*' 'lld-13*' 'lld-14*' 'lld-15*' 'lld-16*' 'lld-17*' 'lld-18*' || true

# clang-19 and lld-19 installed in Dockerfile

# Compile memfd_create_shim.o
clang-19 -c -o /tmp/memfd_create_shim.o tools/memfd_create_shim.c -fPIC

# Download and extract sysroot tarball
SYSROOT_URL="https://github.com/denoland/deno_sysroot_build/releases/download/sysroot-20250207/sysroot-$(uname -m).tar.xz"
echo "Downloading sysroot from $SYSROOT_URL"
wget -q "$SYSROOT_URL" -O /tmp/sysroot.tar.xz

echo "Extracting sysroot to /sysroot"
mkdir -p /sysroot
tar -xJf /tmp/sysroot.tar.xz -C /sysroot

# Note: Mounts are skipped in container environment

# Load sysroot environment variables
if [[ -f /sysroot/.env ]]; then
  echo "Loading sysroot environment variables"
  set -a
  source /sysroot/.env
  set +a
fi

# Export environment variables for incremental LTO and sysroot build
cat <<EOF >> /etc/environment
CARGO_PROFILE_BENCH_INCREMENTAL=false
CARGO_PROFILE_RELEASE_INCREMENTAL=false
RUSTFLAGS="
  -C linker-plugin-lto=true
  -C linker=clang-19
  -C link-arg=-fuse-ld=lld-19
  -C link-arg=-ldl
  -C link-arg=-Wl,--allow-shlib-undefined
  -C link-arg=-Wl,--thinlto-cache-dir=$(pwd)/target/release/lto-cache
  -C link-arg=-Wl,--thinlto-cache-policy,cache_size_bytes=700m
  -C link-arg=/tmp/memfd_create_shim.o
  --cfg tokio_unstable
  \$RUSTFLAGS
"
RUSTDOCFLAGS="
  -C linker-plugin-lto=true
  -C linker=clang-19
  -C link-arg=-fuse-ld=lld-19
  -C link-arg=-ldl
  -C link-arg=-Wl,--allow-shlib-undefined
  -C link-arg=-Wl,--thinlto-cache-dir=$(pwd)/target/release/lto-cache
  -C link-arg=-Wl,--thinlto-cache-policy,cache_size_bytes=700m
  -C link-arg=/tmp/memfd_create_shim.o
  --cfg tokio_unstable
  \$RUSTFLAGS
"
CC=/usr/bin/clang-19
CFLAGS=\$CFLAGS
EOF

export CARGO_PROFILE_BENCH_INCREMENTAL=false
export CARGO_PROFILE_RELEASE_INCREMENTAL=false
export RUSTFLAGS="
  -C linker-plugin-lto=true
  -C linker=clang-19
  -C link-arg=-fuse-ld=lld-19
  -C link-arg=-ldl
  -C link-arg=-Wl,--allow-shlib-undefined
  -C link-arg=-Wl,--thinlto-cache-dir=$(pwd)/target/release/lto-cache
  -C link-arg=-Wl,--thinlto-cache-policy,cache_size_bytes=700m
  -C link-arg=/tmp/memfd_create_shim.o
  --cfg tokio_unstable
  $RUSTFLAGS
"
export RUSTDOCFLAGS="$RUSTFLAGS"
export CC=/usr/bin/clang-19

echo "Sysroot and LTO environment configured."

# Build release with cargo
echo "Building release with cargo..."
cargo build --release --locked --all-targets --features=panic-trace

# Check deno binary
echo "Checking deno binary..."
target/release/deno eval "console.log(1+2)" | grep 3

# Run tests
echo "Running cargo tests..."
cargo test --release --locked --features=panic-trace

# Run web platform tests if WPT enabled
if [[ "${WPT:-0}" == "1" ]]; then
  echo "Running web platform tests (release)..."
  export DENO_BIN=./target/release/deno
  deno run -RWNE --allow-run --lock=tools/deno.lock.json --config tests/config/deno.json ./tests/wpt/wpt.ts setup
  deno run -RWNE --allow-run --lock=tools/deno.lock.json --config tests/config/deno.json --unsafely-ignore-certificate-errors ./tests/wpt/wpt.ts run --quiet --release --binary="$DENO_BIN" --json=wpt.json --wptreport=wptreport.json
fi

echo "Build and test completed successfully."