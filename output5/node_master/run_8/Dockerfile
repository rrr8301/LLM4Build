# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    clang \
    make \
    nodejs \
    npm \
    python3 \
    python3-venv \
    python3-pip \
    curl \
    g++ \
    gcc \
    wget \
    perl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install OpenSSL 1.1.1
RUN wget https://www.openssl.org/source/openssl-1.1.1u.tar.gz && \
    tar -xzf openssl-1.1.1u.tar.gz && \
    cd openssl-1.1.1u && \
    ./config && \
    make && \
    make install && \
    cd .. && \
    rm -rf openssl-1.1.1u openssl-1.1.1u.tar.gz

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install sccache
RUN curl -L https://github.com/mozilla/sccache/releases/download/v0.10.0/sccache-v0.10.0-x86_64-unknown-linux-musl.tar.gz | tar xz && \
    mv sccache-v0.10.0-x86_64-unknown-linux-musl/sccache /usr/local/bin/

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]