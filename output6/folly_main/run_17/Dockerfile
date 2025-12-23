# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python 3, build tools, and necessary dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    cmake \
    make \
    g++ \
    git \
    autoconf \
    automake \
    binutils-dev \
    libboost-all-dev \
    libdouble-conversion-dev \
    libdwarf-dev \
    libevent-dev \
    libgflags-dev \
    liblz4-dev \
    libsnappy-dev \
    libsodium-dev \
    libtool \
    libzstd-dev \
    ninja-build \
    zlib1g-dev \
    zstd \
    libssl-dev \
    libgtest-dev \
    libgmock-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]