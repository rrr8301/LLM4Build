# Use Ubuntu 22.04 as base image to match GitHub Actions environment
FROM ubuntu:22.04

# Set timezone to Pacific Time non-interactively
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && apt-get install -y \
    git \
    wget \
    # JDK 17 (Temurin)
    && apt-get install -y wget apt-transport-https gnupg \
    && wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | apt-key add - \
    && echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list \
    && apt-get update \
    && apt-get install -y temurin-17-jdk \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /workspace

# Copy repository contents
COPY . .

# Copy and make run.sh executable
COPY run.sh /workspace/run.sh
RUN chmod +x /workspace/run.sh

# Set entrypoint
ENTRYPOINT ["/workspace/run.sh"]