# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    maven \
    && rm -rf /var/lib/apt/lists/*

# Set up JDK 17 (Temurin)
RUN mkdir -p /usr/lib/jvm && \
    curl -L -o /tmp/openjdk-17.tar.gz https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.8+7/OpenJDK17U-jdk_x64_linux_hotspot_17.0.8_7.tar.gz && \
    tar -xzf /tmp/openjdk-17.tar.gz -C /usr/lib/jvm && \
    rm /tmp/openjdk-17.tar.gz
ENV JAVA_HOME=/usr/lib/jvm/jdk-17.0.8+7
ENV PATH="$JAVA_HOME/bin:$PATH"

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]