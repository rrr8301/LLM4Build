# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt-get update && \
    apt-get install -y gcc-13 g++-13 make curl file && \  # Added 'file' package
    curl -L https://github.com/microsoft/vcpkg/archive/refs/tags/2023.09.15.tar.gz -o vcpkg.tar.gz && \
    if ! file vcpkg.tar.gz | grep -q 'gzip compressed data'; then echo "vcpkg.tar.gz is not a valid gzip file"; exit 1; fi && \
    tar -xzf vcpkg.tar.gz && \
    mv vcpkg-2023.09.15 vcpkg && \
    cd vcpkg && ./bootstrap-vcpkg.sh && ./vcpkg install abseil gtest benchmark && \
    cd .. && rm -rf vcpkg vcpkg.tar.gz && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV CC=gcc-13
ENV CXX=g++-13
ENV PKG_CONFIG_PATH=/usr/local/share/vcpkg/installed/x64-linux/lib/pkgconfig

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]