# run.sh
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Build the project
npm run build

# Run tests, ensuring all tests are executed even if some fail
set +e
npm test
TEST_EXIT_CODE=$?
set -e

# Exit with the test command's exit code
exit $TEST_EXIT_CODE