# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    lldb \
    gcc-multilib \
    libsecret-1-0 \
    libsecret-1-dev \
    curl \
    build-essential \
    dos2unix

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Set Rust to stable and add components and targets
RUN rustup update --no-self-update stable && \
    rustup default stable && \
    rustup target add i686-unknown-linux-gnu && \
    rustup target add wasm32-unknown-unknown && \
    rustup component add rustc-dev llvm-tools-preview rust-docs rustfmt || echo "rustfmt not available"

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]