FROM ghcr.io/linux-nvme/debian.python:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    meson \
    gcc \
    make \
    git \
    ninja-build \
    pkg-config \
    cmake \
    autoconf \
    automake \
    libtool \
    libjson-c-dev \
    libssl-dev \
    libudev-dev \
    uuid-dev \
    libkeyutils-dev

# Install libnvme from source (version >=1.15)
RUN git clone https://github.com/linux-nvme/libnvme.git /tmp/libnvme && \
    cd /tmp/libnvme && \
    git checkout v1.15 && \
    meson setup build --prefix=/usr && \
    meson compile -C build && \
    meson install -C build && \
    ldconfig

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Make scripts executable
RUN chmod +x scripts/build.sh && \
    chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]