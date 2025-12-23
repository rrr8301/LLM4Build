FROM ubuntu:22.04

# Set timezone to avoid interactive prompt
ENV DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    g++ \
    cmake \
    libboost-all-dev \
    libevent-dev \
    libdouble-conversion-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libiberty-dev \
    liblz4-dev \
    liblzma-dev \
    libsnappy-dev \
    make \
    zlib1g-dev \
    binutils-dev \
    libjemalloc-dev \
    libssl-dev \
    pkg-config \
    libsodium-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /mvfst

# Copy repository
COPY . .

# Copy and make run.sh executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]