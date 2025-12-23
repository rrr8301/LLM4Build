FROM ubuntu:22.04

# Install required packages
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    make \
    autoconf \
    automake \
    libtool \
    pkg-config \
    libssl-dev \
    libpam0g-dev \
    libx11-dev \
    libxfixes-dev \
    libxrandr-dev \
    cmake \
    ninja-build \
    git \
    libimlib2-dev \
    lsb-release \
    libfuse3-dev \
    libfdk-aac-dev \
    libopus-dev \  # Added missing package
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]