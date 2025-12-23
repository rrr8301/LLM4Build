# Use Ubuntu 22.04 as base
FROM ubuntu:22.04

# Arguments for JDK and Zookeeper versions
ARG JDK_VERSION=17
ARG ZOOKEEPER_VERSION=3.7.0

ENV DEBIAN_FRONTEND=noninteractive
ENV DISABLE_FILE_SYSTEM_TEST=true
ENV ZOOKEEPER_VERSION=${ZOOKEEPER_VERSION}
ENV JAVA_HOME=/usr/lib/jvm/java-${JDK_VERSION}-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Install required packages and OpenJDK
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-${JDK_VERSION}-jdk \
    curl \
    wget \
    unzip \
    ca-certificates \
    bash \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create workspace directory
WORKDIR /workspace

# Copy source code (assumed to be mounted or copied during build)
COPY . /workspace

# Ensure mvnw is executable
RUN chmod +x ./mvnw

# Copy run.sh and make executable
COPY run.sh /workspace/run.sh
RUN chmod +x /workspace/run.sh

ENTRYPOINT ["/workspace/run.sh"]