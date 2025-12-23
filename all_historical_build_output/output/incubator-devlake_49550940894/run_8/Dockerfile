# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Go
RUN curl -OL https://golang.org/dl/go1.18.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.18.linux-amd64.tar.gz && \
    rm go1.18.linux-amd64.tar.gz

# Set Go environment variables
ENV PATH="/usr/local/go/bin:${PATH}"

# Create work directory
WORKDIR /app

# Ensure go.mod and go.sum are present in the build context
# Copy only the go.mod and go.sum files first to leverage Docker cache
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download || echo "go.mod or go.sum not found, skipping go mod download"

# Copy the rest of the application code
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]