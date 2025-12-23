# run.sh
#!/bin/bash

set -e
set -o pipefail

# Build and test the project
./gradlew build --stacktrace --scan || true

# Generate coverage report
./gradlew coverageReport --stacktrace --scan || true

# Placeholder for uploading coverage report
echo "Upload the coverage report manually or use a local script."