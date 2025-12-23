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
    && rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /usr/src/rustpython

# Copy the entire project
COPY . .

# Create Lib directory and copy files if they exist
RUN mkdir -p /usr/src/rustpython/Lib && \
    { [ -d crates/pylib/Lib ] && cp -r crates/pylib/Lib/* /usr/src/rustpython/Lib/ || true; } && \
    { [ -d crates/vm/Lib ] && cp -r crates/vm/Lib/* /usr/src/rustpython/Lib/ || true; }

# Make run.sh executable and set as entrypoint
COPY run.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]