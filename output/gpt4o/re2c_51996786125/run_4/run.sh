#!/bin/bash
set -e

# Activate Python virtual environment
source /opt/venv/bin/activate

# Run CMake configuration and build steps
cmake --list-presets
cmake --preset=linux-gcc-debug-ootree-skeleton-fast -DPython3_ROOT_DIR="/opt/venv"
cmake --build --preset=linux-gcc-debug-ootree-skeleton-fast -j$(nproc)
cmake --build --preset=linux-gcc-debug-ootree-skeleton-fast --target install

# Run minimal install test
cd install/bin
./re2c --version
cd -

# Full configure and build
cmake --preset=linux-gcc-debug-ootree-skeleton-full -DPython3_ROOT_DIR="/opt/venv"
find src -name '*.re' | xargs touch
cmake --build --preset=linux-gcc-debug-ootree-skeleton-full -j$(nproc)

# Run main test suite
ulimit -s 256
cmake --build --preset=linux-gcc-debug-ootree-skeleton-full --target tests -j$(nproc)

# Determine build directory
if echo "linux-gcc-debug-ootree-skeleton" | grep -q "ootree"; then
    BUILD_DIR="/workspace/.build/linux-gcc-debug-ootree-skeleton-full"
else
    BUILD_DIR="/workspace"
fi

# Run skeleton tests from the correct directory with more verbose output
cd "$BUILD_DIR"
set +e  # Disable exit on error to ensure all tests run
echo "Running skeleton tests..."
python run_tests.py --skeleton --verbose
TEST_RESULT=$?
set -e  # Re-enable exit on error

# Print detailed test results
echo "Test results:"
cat test_results.log 2>/dev/null || echo "No detailed test results available"

# Exit with appropriate status
if [ $TEST_RESULT -eq 0 ]; then
    echo "All tests passed"
    exit 0
else
    echo "Some tests failed"
    # Archive test artifacts for debugging
    mkdir -p /workspace/test_artifacts
    cp -r test_* /workspace/test_artifacts/ 2>/dev/null || true
    exit $TEST_RESULT
fi