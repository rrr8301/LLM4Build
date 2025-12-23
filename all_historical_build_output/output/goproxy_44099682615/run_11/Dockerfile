# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    dos2unix \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Go
ENV GO_VERSION=1.22
RUN curl -sSL https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz | tar -C /usr/local -xz

# Set Go environment variables
ENV PATH="/usr/local/go/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN dos2unix /usr/local/bin/run.sh && chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]