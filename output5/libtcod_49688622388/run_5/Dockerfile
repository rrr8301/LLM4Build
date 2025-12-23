# Dockerfile
FROM ubuntu:24.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    cmake \
    ninja-build \
    g++ \
    make \
    libltdl-dev \
    libx11-dev \
    libxft-dev \
    libxext-dev \
    libwayland-dev \
    libxkbcommon-dev \
    libegl1-mesa-dev \
    libibus-1.0-dev \
    dos2unix \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Initialize and update vcpkg submodule
RUN git submodule update --init --recursive

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]