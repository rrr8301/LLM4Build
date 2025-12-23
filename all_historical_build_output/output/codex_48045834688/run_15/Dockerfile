# Dockerfile
FROM ubuntu:24.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    musl-tools \
    pkg-config \
    curl \
    build-essential \
    dos2unix

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup toolchain install 1.88
RUN rustup component add clippy

# Create work directory
WORKDIR /app

# Copy only necessary files
# Ensure Cargo.toml and Cargo.lock are in the build context
COPY . /app/

# Copy run.sh and make it executable
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]