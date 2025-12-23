# Dockerfile
FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies including ca-certificates for SSL
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libbrotli-dev \
    libbz2-dev \
    libclang-18-dev \
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
    python3-pip \
    python3-setuptools \
    python3-wheel \
    python3-venv \
    rcs \
    tcl-dev \
    tk-dev \
    zlib1g-dev \
    curl \
    ca-certificates \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Rust with proper SSL certificates
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup component add rustfmt rustc-dev

# Create work directory
WORKDIR /workspace

# Clone c2rust and testsuite
RUN git clone https://github.com/immunant/c2rust.git && \
    git clone https://github.com/immunant/c2rust-testsuite.git testsuite && \
    cd testsuite && git submodule update --init --recursive

# Create and activate Python virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Python packages in virtual environment
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install -r /workspace/testsuite/requirements.txt

# Copy run.sh and make it executable
COPY run.sh /workspace/run.sh
RUN chmod +x /workspace/run.sh

# Set entrypoint
ENTRYPOINT ["/workspace/run.sh"]