# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    libssl-dev \
    pkg-config \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install Rust components
RUN rustup component add clippy

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Ensure run.sh has Unix line endings and make it executable
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]