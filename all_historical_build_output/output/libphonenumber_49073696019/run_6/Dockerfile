# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    cmake-curses-gui \
    libprotobuf-dev \
    libgtest-dev \
    libre2-dev \
    libicu-dev \
    libboost-dev \
    libboost-thread-dev \
    libboost-system-dev \
    protobuf-compiler \
    make \
    git \
    ca-certificates \
    openjdk-11-jre-headless \  # Install Java Runtime Environment
    && rm -rf /var/lib/apt/lists/*

# Install Abseil C++ library
RUN git clone https://github.com/abseil/abseil-cpp.git /tmp/abseil-cpp && \
    cd /tmp/abseil-cpp && \
    mkdir build && cd build && \
    cmake .. -DCMAKE_POSITION_INDEPENDENT_CODE=ON && \
    make -j && make install && \
    cd / && rm -rf /tmp/abseil-cpp

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]