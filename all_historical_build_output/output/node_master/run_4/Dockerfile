# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-pip \
    clang \
    make \
    curl \
    wget && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Install OpenSSL 1.1.1 (or another compatible version)
RUN wget https://www.openssl.org/source/openssl-1.1.1l.tar.gz && \
    tar -xzf openssl-1.1.1l.tar.gz && \
    cd openssl-1.1.1l && \
    ./config && \
    make && \
    make install && \
    cd .. && \
    rm -rf openssl-1.1.1l openssl-1.1.1l.tar.gz

# Ensure OpenSSL 1.1.1 is used
RUN ln -sf /usr/local/lib/libssl.so.1.1 /usr/lib/libssl.so && \
    ln -sf /usr/local/lib/libcrypto.so.1.1 /usr/lib/libcrypto.so

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]