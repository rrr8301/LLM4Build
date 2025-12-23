# Use official Rust stable image as base
FROM rust:latest

# Set timezone to Pacific Time non-interactively
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required system packages
RUN apt-get update && apt-get install -y \
    clang \
    cmake \
    make \
    autoconf \
    automake \
    libtool \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /usr/src/rustpython

# Copy the entire project
COPY . .

# Skip Python compilation during tests
ENV RUSTPYTHON_SKIP_PYTHON_COMPILE=1

# Ensure Lib directories exist
RUN mkdir -p Lib/python_builtins Lib/core_modules

# Make run.sh executable and set as entrypoint
COPY run.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]