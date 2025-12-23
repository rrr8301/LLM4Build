#!/bin/bash

# Print Java version
java -version

# Set environment variable for the build script
export JOB_TYPE=test

# Run the build script
./.kokoro/build.sh

# Run tests using Maven, ensuring all tests are executed
mvn test --fail-at-end