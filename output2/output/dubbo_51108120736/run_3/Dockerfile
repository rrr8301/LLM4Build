# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    unzip \
    git \
    maven \
    gnupg \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Install Zulu JDK 11
RUN wget -qO - https://repos.azul.com/azul-repo.key | apt-key add - && \
    echo "deb http://repos.azul.com/zulu/deb stable main" | tee /etc/apt/sources.list.d/zulu.list && \
    apt-get update && apt-get install -y zulu11-jdk

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Convert line endings of run.sh and make it executable
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]