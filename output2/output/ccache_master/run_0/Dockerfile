# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

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
    g++-12 \
    g++-12-multilib \
    ninja-build

# Set environment variables for compiler
ENV CC=gcc-12
ENV CXX=g++-12

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]