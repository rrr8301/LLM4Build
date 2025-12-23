# syntax=docker/dockerfile:1.4

# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Enable BuildKit
ENV DOCKER_BUILDKIT=1

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Use a different mirror for apt-get
RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|http://mirror.math.princeton.edu/pub/ubuntu/|g' /etc/apt/sources.list

# Install curl and other necessary packages with retries
RUN apt-get update -o Acquire::Retries=3 && \
    apt-get install -y --no-install-recommends curl ca-certificates gnupg dirmngr libldap-2.5-0 -o Acquire::Retries=3 && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js 18.x and pnpm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get update -o Acquire::Retries=3 && \
    apt-get install -y --no-install-recommends nodejs -o Acquire::Retries=3 && \
    npm install -g pnpm@8 && \
    rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Install project dependencies
RUN pnpm install

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]