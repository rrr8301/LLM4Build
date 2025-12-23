# Use the base image
FROM ubuntu:24.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    elfutils \
    libhiredis-dev \
    libzstd-dev \
    python3 \
    redis-server \
    redis-tools \
    lld \
    g++-13 \
    g++-13-multilib \
    cmake \
    ninja-build

# Set environment variables
ENV CTEST_OUTPUT_ON_FAILURE=ON
ENV VERBOSE=1
ENV CMAKE_GENERATOR=Ninja
ENV CC=gcc-13
ENV CXX=g++-13

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]