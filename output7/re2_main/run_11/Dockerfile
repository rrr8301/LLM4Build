# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    make \
    lsb-release \
    software-properties-common \
    gnupg \
    git \
    curl \
    zip \
    unzip \
    tar \
    build-essential \
    cmake \
    ninja-build \
    pkg-config && \
    rm -rf /var/lib/apt/lists/*  # Clean up APT cache

# Install Clang 20
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x ./llvm.sh && \
    ./llvm.sh 20 && \
    rm llvm.sh

# Install vcpkg
RUN git clone https://github.com/microsoft/vcpkg.git /vcpkg && \
    /vcpkg/bootstrap-vcpkg.sh

# Set environment variables for vcpkg
ENV VCPKG_ROOT=/vcpkg
ENV PATH="$VCPKG_ROOT:$PATH"
ENV PKG_CONFIG_PATH="$VCPKG_ROOT/installed/x64-linux/lib/pkgconfig:$PKG_CONFIG_PATH"

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install dependencies using vcpkg
RUN vcpkg update && \
    vcpkg install abseil gtest benchmark

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]