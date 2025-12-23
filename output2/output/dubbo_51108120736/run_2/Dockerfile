# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl \
    openjdk-11-jdk \
    maven \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Set up work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Convert line endings of run.sh to Unix format and make it executable
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/bin/bash", "/app/run.sh"]