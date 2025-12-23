# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    elfutils \
    libhiredis-dev \
    libzstd-dev \
    python3 \
    redis-server \
    redis-tools \
    binutils \
    doctest-dev \
    libfmt-dev \
    libxxhash-dev \
    g++-11 \
    g++-11-multilib \
    cmake \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV CC=gcc-11
ENV CXX=g++-11

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]