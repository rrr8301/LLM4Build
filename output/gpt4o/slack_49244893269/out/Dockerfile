# Dockerfile
FROM ubuntu:24.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies including C compiler for cgo
RUN apt-get update && apt-get install -y \
    git \
    wget \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Install Go (using version 1.22 as likely intended in YAML)
RUN wget https://dl.google.com/go/go1.22.0.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz && \
    rm go1.22.0.linux-amd64.tar.gz

# Set Go environment variables including CGO_ENABLED
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH=/go
ENV GOCACHE=/go/.cache
ENV CGO_ENABLED=1

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]