FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    ninja-build \
    python3 \
    python3-pip \
    git \
    wget \
    curl \
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
    libssl-dev \
    libtool \
    libzstd-dev \
    zlib1g-dev \
    zstd && \
    rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install Python dependencies if any
# RUN pip3 install -r requirements.txt  # Uncomment if there is a requirements file

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]