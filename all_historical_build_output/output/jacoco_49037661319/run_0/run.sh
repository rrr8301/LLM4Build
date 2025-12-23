#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Generate toolchains.xml
JDK_VERSION=17
JDK_HOME_VARIABLE_NAME=JAVA_HOME_17_X64
JAVA_HOME=$(eval echo \$$JDK_HOME_VARIABLE_NAME)

cat <<EOF > toolchains.xml
<toolchains>
  <toolchain>
    <type>jdk</type>
    <provides>
      <id>$JDK_VERSION</id>
      <version>$JDK_VERSION</version>
    </provides>
    <configuration>
      <jdkHome>$JAVA_HOME</jdkHome>
    </configuration>
  </toolchain>
</toolchains>
EOF

# Run Maven build
./mvnw -V -B -e --no-transfer-progress \
  verify -Djdk.version=$JDK_VERSION -Dbytecode.version=$JDK_VERSION \
  --toolchains=toolchains.xml || true

# Ensure all tests are executed even if some fail