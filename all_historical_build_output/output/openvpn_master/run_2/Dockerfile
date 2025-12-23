# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    liblzo2-dev \
    libpam0g-dev \
    liblz4-dev \
    libcap-ng-dev \
    libnl-genl-3-dev \
    linux-libc-dev \
    man2html \
    libcmocka-dev \
    python3-docutils \
    libtool \
    automake \
    autoconf \
    libssl-dev \
    libpkcs11-helper1-dev \
    softhsm2 \
    gnutls-bin \
    git \
    make \
    gcc \
    pkg-config \
    sudo \  # Added sudo
    iproute2  # Added iproute2 for the ip command

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Run autoreconf
RUN autoreconf -fvi

# Configure the project
RUN ./configure --with-crypto-library=openssl --enable-pkcs11 --enable-werror

# Build the project
RUN make -j3

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]