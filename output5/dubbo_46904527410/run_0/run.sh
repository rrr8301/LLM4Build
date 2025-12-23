#!/usr/bin/env bash
set -euo pipefail

# Environment variables
export DISABLE_FILE_SYSTEM_TEST=true

# Variables (can be overridden by environment)
JDK_VERSION=${JDK_VERSION:-17}
ZOOKEEPER_VERSION=${ZOOKEEPER_VERSION:-3.7.0}
ZOOKEEPER_DIR=".tmp/zookeeper"
ZOOKEEPER_ARCHIVE="apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz"
ZOOKEEPER_URL="https://downloads.apache.org/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/${ZOOKEEPER_ARCHIVE}"

echo "Using JDK version: $JDK_VERSION"
echo "Using Zookeeper version: $ZOOKEEPER_VERSION"

# Check Java version
java -version

# Download and extract Zookeeper if not already present
if [ ! -d "$ZOOKEEPER_DIR" ]; then
  echo "Downloading Zookeeper $ZOOKEEPER_VERSION..."
  mkdir -p "$ZOOKEEPER_DIR"
  curl -fsSL "$ZOOKEEPER_URL" -o /tmp/$ZOOKEEPER_ARCHIVE
  tar -xzf /tmp/$ZOOKEEPER_ARCHIVE -C "$ZOOKEEPER_DIR" --strip-components=1
  rm /tmp/$ZOOKEEPER_ARCHIVE
else
  echo "Zookeeper already downloaded in $ZOOKEEPER_DIR"
fi

# Run Maven tests with integration tests enabled (Ubuntu path)
echo "Running Maven tests with integration tests..."

./mvnw --batch-mode --no-snapshot-updates -e --no-transfer-progress --fail-fast clean test verify \
  -Pjacoco \
  -Dmaven.wagon.httpconnectionManager.ttlSeconds=120 \
  -Dmaven.wagon.http.retryHandler.count=5 \
  -DskipTests=false \
  -DskipIntegrationTests=false \
  -Dcheckstyle.skip=false \
  -Dcheckstyle_unix.skip=false \
  -Drat.skip=false \
  -Dmaven.javadoc.skip=true \
  -DembeddedZookeeperPath="$(pwd)/$ZOOKEEPER_DIR"

echo "Tests completed successfully."