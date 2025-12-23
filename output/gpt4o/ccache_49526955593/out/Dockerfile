FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
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
    cmake \
    ninja-build && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV CC=gcc-12
ENV CXX=g++-12
ENV CMAKE_GENERATOR=Ninja

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Make ci scripts executable
RUN chmod +x ci/build ci/collect-testdir

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]