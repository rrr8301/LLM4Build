# Dockerfile
FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies including CA certificates and git
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    g++ \
    curl \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Configure git symlinks (needed for cxx build)
RUN git config --global core.symlinks true

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Set up Rust toolchain
RUN rustup component add rust-src

# Create work directory and clone repository with symlinks enabled
WORKDIR /app
RUN git clone -c core.symlinks=true https://github.com/dtolnay/cxx.git . || \
    (git init && \
     git config core.symlinks true && \
     git remote add origin https://github.com/dtolnay/cxx.git && \
     git fetch && \
     git checkout -f main)

# Make run.sh executable
RUN chmod +x run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]