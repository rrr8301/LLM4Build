# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && apt-get install -y \
    qemu \
    docker.io \
    golang \
    curl && \
    rm -rf /var/lib/apt/lists/*

# Install Docker Buildx
RUN mkdir -p /root/.docker/cli-plugins/ && \
    curl -L https://github.com/docker/buildx/releases/latest/download/buildx-v0.10.4.linux-amd64 -o /root/.docker/cli-plugins/docker-buildx && \
    chmod +x /root/.docker/cli-plugins/docker-buildx

# Set Go environment variables
ENV PATH="/usr/lib/go/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Ensure go.mod is valid before running go mod tidy
RUN if [ -f go.mod ]; then sed -i '/^tool/d' go.mod; fi

# Install Go dependencies
RUN go mod tidy

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]