FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    sudo \
    git \
    cmake \
    ninja-build \
    g++ \
    make \
    libssl-dev \
    pkg-config \
    libboost-all-dev \
    libdouble-conversion-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    libevent-dev \
    libfmt-dev \
    liblz4-dev \
    libzstd-dev \
    libsnappy-dev \
    libbz2-dev \
    libiberty-dev \
    liblzma-dev \
    libunwind-dev

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install Python dependencies if any (none specified)

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]