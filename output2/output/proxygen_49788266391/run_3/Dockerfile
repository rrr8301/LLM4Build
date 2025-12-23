FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    build-essential \
    cmake \
    ninja-build \
    git \
    wget \
    curl \
    sudo \
    xz-utils \
    libssl-dev \
    zlib1g-dev \
    libboost-all-dev \
    libevent-dev \
    libdouble-conversion-dev \
    libfmt-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    liblz4-dev \
    libsnappy-dev \
    libunwind-dev \
    libiberty-dev \
    libdwarf-dev \
    libtool \
    autoconf \
    automake \
    gperf \
    libsodium-dev

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Make run.sh executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]