FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python, OpenSSL, and necessary build tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-setuptools \
    cmake \
    ninja-build \
    g++ \
    make \
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
    zlib1g-dev \
    zstd \
    libssl-dev && \  # Corrected the misplaced backslash
    rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Set environment variable to bypass sudo
ENV GETDEPS_NO_SUDO=1

# Install system dependencies using getdeps.py
RUN python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive folly || true

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]