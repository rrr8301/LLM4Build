# Use Ubuntu 22.04 as base image
FROM ubuntu:22.04

# Set timezone to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    gnome-keyring \
    build-essential \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install mold linker
RUN curl -L https://github.com/rui314/mold/releases/download/v1.11.0/mold-1.11.0-x86_64-linux.tar.gz | tar -xz \
    && mv mold-1.11.0-x86_64-linux/bin/mold /usr/local/bin/ \
    && rm -rf mold-1.11.0-x86_64-linux

# Install uv (Python package manager)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.cargo/bin:/root/.local/bin:${PATH}"

# Install cargo-nextest
RUN cargo install cargo-nextest

# Create work directory
WORKDIR /workspace

# Copy repository
COPY . .

# Copy and make run.sh executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]