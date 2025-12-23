FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies and CA certificates
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
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Add Rust components
RUN rustup component add rustfmt rustc-dev

# Create work directory
WORKDIR /workspace

# Copy repository contents
COPY . .

# Install Python packages
RUN python3 -m pip install -r testsuite/requirements.txt

# Build the project
RUN export LLVM_CONFIG_PATH=/usr/bin/llvm-config-15 && cargo build --release

# Copy run.sh and make it executable
COPY run.sh /workspace/run.sh
RUN chmod +x /workspace/run.sh

# Set entrypoint
ENTRYPOINT ["/workspace/run.sh"]