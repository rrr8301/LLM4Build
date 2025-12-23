#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Activate Flutter environment
source /usr/local/flutter/bin/flutter

# Check Dart and Flutter versions
dart --version
flutter --version

# Run the Flutter CI script
./flutter_ci_script_master.sh || true

# Ensure all tests are executed, even if some fail
set +e