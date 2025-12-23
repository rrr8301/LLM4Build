FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    elfutils \
    libhiredis-dev \
    libzstd-dev \
    python3 \
    redis-server \
    redis-tools \
    binutils \
    doctest-dev \
    libfmt-dev \
    libxxhash-dev \
    clang-15 \
    g++-multilib \
    lld-15 \
    cmake \
    ninja-build

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy and set permissions for run.sh
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]