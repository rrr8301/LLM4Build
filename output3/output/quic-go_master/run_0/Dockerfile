# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && apt-get install -y \
    qemu \
    docker.io \
    buildx \
    golang-1.20 \
    && rm -rf /var/lib/apt/lists/*

# Set Go environment variables
ENV PATH="/usr/lib/go-1.20/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install Go dependencies
RUN go mod tidy

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]