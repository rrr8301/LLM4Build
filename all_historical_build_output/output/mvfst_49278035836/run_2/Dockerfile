# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
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
    python3 \
    python3-pip \
    git \
    dos2unix

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Check if requirements.txt exists and install Python dependencies
RUN if [ -f requirements.txt ]; then pip3 install --no-cache-dir -r requirements.txt; fi

# Make run.sh executable and set as entrypoint
COPY run.sh /app/run.sh
RUN dos2unix /app/run.sh && chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]