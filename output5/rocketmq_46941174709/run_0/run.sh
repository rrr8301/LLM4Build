#!/bin/bash
set -e

echo "Using Java version:"
java -version

echo "Building project with Maven..."
mvn -B package --file pom.xml

echo "Build completed."