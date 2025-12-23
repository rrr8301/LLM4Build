#!/bin/bash

# Run tests
pytest --junitxml=test-results/results.xml

# Exit with the result of pytest
exit $?