# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    clang clang-tools cmake curl git gperf libbrotli-dev libclang-15-dev \
    libgcrypt20 libreadline-dev libidn2-dev libldap2-dev libncurses5-dev \
    libnghttp2-dev libpcre3-dev libpsl-dev librtmp-dev libssl-dev libtool \
    libz3-dev llvm llvm-dev luarocks ninja-build pkg-config rcs strace unzip \
    zlib1g-dev python3 python3-pip

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install Python packages
RUN pip3 install -r ./scripts/requirements.txt

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]