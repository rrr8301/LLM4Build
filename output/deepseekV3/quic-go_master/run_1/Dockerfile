# Use official Golang image as base
FROM golang:latest

# Set timezone to Pacific Time non-interactively
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && apt-get install -y \
    docker.io \
    qemu-system-x86 qemu-user-static \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Docker Buildx
RUN mkdir -p ~/.docker/cli-plugins && \
    curl -sSL https://github.com/docker/buildx/releases/download/v0.10.0/buildx-v0.10.0.linux-amd64 -o ~/.docker/cli-plugins/docker-buildx && \
    chmod +x ~/.docker/cli-plugins/docker-buildx

# Create working directory
WORKDIR /app

# Copy the repository
COPY . .

# Copy the run script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]