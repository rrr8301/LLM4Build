FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    elfutils \
    libhiredis-dev \
    libzstd-dev \
    ninja-build \
    python3 \
    redis-server \
    redis-tools \
    binutils \
    doctest-dev \
    libfmt-dev \
    libxxhash-dev \
    g++-12 \
    g++-12-multilib \
    cmake

# Set environment variables
ENV CC=gcc-12
ENV CXX=g++-12
ENV CMAKE_GENERATOR=Ninja
ENV CTEST_OUTPUT_ON_FAILURE=ON
ENV VERBOSE=1

# Copy the repository
COPY . /app
WORKDIR /app

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]