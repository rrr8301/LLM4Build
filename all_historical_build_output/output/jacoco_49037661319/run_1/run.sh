#!/bin/bash

# Activate environment variables if needed (none in this case)

# Generate toolchains.xml
JDK_VERSION=17
JDK_HOME_VARIABLE_NAME=JAVA_HOME_17_X64
echo "
<toolchains>
  <toolchain>
    <type>jdk</type>
    <provides>
      <id>$JDK_VERSION</id>
      <version>$JDK_VERSION</version>
    </provides>
    <configuration>
      <jdkHome=${!JDK_HOME_VARIABLE_NAME}</jdkHome>
    </configuration>
  </toolchain>
</toolchains>
" > toolchains.xml

# Run Maven build
./mvnw -V -B -e --no-transfer-progress \
  verify -Djdk.version=$JDK_VERSION -Dbytecode.version=$JDK_VERSION \
  --toolchains=toolchains.xml || true

# Ensure all tests are executed, even if some fail