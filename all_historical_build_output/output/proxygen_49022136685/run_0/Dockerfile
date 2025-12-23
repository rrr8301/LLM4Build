# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    build-essential \
    cmake \
    ninja-build \
    zlib1g-dev \
    libzstd-dev \
    libboost-all-dev \
    libdouble-conversion-dev \
    libfmt-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    libgtest-dev \
    libdwarf-dev \
    libevent-dev \
    liblz4-dev \
    libsnappy-dev \
    libssl-dev \
    liboqs-dev \
    autoconf \
    automake \
    libtool \
    gperf \
    libiberty-dev \
    libsodium-dev \
    libunwind-dev \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]