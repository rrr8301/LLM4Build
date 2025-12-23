# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libbrotli-dev \
    libbz2-dev \
    libclang-15-dev \
    libdb-dev \
    libgcrypt20 \
    libgdbm-dev \
    libreadline-dev \
    libidn2-dev \
    libldap2-dev \
    liblzma-dev \
    libnghttp2-dev \
    libpcre3-dev \
    libpsl-dev \
    librtmp-dev \
    libtool \
    libzstd-dev \
    python3-setuptools \
    python3-wheel \
    rcs \
    tcl-dev \
    tk-dev \
    zlib1g-dev \
    python3-pip \
    curl \
    pkg-config \
    libssl-dev \
    llvm-15 \
    llvm-15-dev \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Create work directory
WORKDIR /workspace

# Copy repository contents
COPY . .

# Ensure testsuite directory is copied
COPY testsuite /workspace/testsuite

# Install Python packages
RUN if [ -f testsuite/requirements.txt ]; then python3 -m pip install -r testsuite/requirements.txt; fi

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]