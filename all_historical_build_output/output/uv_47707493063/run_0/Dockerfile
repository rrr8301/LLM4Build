# Dockerfile
FROM ubuntu:22.04

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    pkg-config \
    libssl-dev \
    libffi-dev \
    python3-dev

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install Python using uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN uv python install 3.12

# Install cargo-nextest
RUN cargo install cargo-nextest

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy and set run.sh as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]