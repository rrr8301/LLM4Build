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

# Install Python using pyenv
RUN curl https://pyenv.run | bash
ENV PATH="/root/.pyenv/bin:/root/.pyenv/shims:${PATH}"
RUN pyenv install 3.12.0
RUN pyenv global 3.12.0

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