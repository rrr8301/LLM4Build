# Dockerfile
FROM ubuntu:22.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    maven \
    openjdk-21-jdk \
    && rm -rf /var/lib/apt/lists/*

# Set up Zulu JDK 21
RUN wget -qO- https://cdn.azul.com/zulu/bin/zulu21.32.11-ca-jdk21.0.0-linux_x64.tar.gz | tar -xz -C /opt \
    && mv /opt/zulu21.32.11-ca-jdk21.0.0-linux_x64 /opt/zulu-jdk

ENV JAVA_HOME=/opt/zulu-jdk
ENV PATH="$JAVA_HOME/bin:$PATH"

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Ensure run.sh is executable
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/bin/bash", "/app/run.sh"]