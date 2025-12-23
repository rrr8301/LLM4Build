# Dockerfile
FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    make \
    curl \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Install Go - using version 1.24.0 as required by dependencies
RUN curl -LO https://golang.org/dl/go1.24.0.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.24.0.linux-amd64.tar.gz && \
    rm go1.24.0.linux-amd64.tar.gz

# Set Go environment
ENV GOPATH=/go
ENV PATH="/usr/local/go/bin:/go/bin:${PATH}"
ENV CGO_ENABLED=1

# Create work directory
WORKDIR /app

# Install gotestsum and tparse
RUN go install gotest.tools/gotestsum@latest && \
    go install github.com/mfridman/tparse@latest

# Copy repository
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]