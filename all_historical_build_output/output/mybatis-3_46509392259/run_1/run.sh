#!/bin/bash
set -euo pipefail

# Run Maven tests with the specified profile and options
./mvnw test -B -V --no-transfer-progress -Dlicense.skip=true -PtestContainers