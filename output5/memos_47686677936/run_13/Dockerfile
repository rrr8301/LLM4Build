# Use a valid Go version
FROM ubuntu:22.04

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Install Go (use a valid version, e.g., 1.21)
RUN wget https://go.dev/dl/go1.21.0.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.21.0.linux-amd64.tar.gz && \
    rm go1.21.0.linux-amd64.tar.gz

# Set Go environment variables
ENV PATH="/usr/local/go/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Initialize Go module if not already initialized
RUN if [ ! -f go.mod ]; then go mod init $(basename $(pwd)); fi

# Set the Go version explicitly in go.mod to match the installed version
RUN if ! grep -q '^go ' go.mod; then echo "go 1.21" >> go.mod; fi

# Ensure the Go version in go.mod matches the installed version
RUN sed -i 's/^go [0-9]\+\.[0-9]\+\.[0-9]\+/go 1.21/' go.mod

# Install Go dependencies
RUN go mod tidy || true

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/bin/bash", "/app/run.sh"]