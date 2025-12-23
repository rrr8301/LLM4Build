FROM ubuntu:24.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies with proper locale settings
RUN apt-get update && \
    apt-get install -qy --no-install-recommends \
    bzip2 \
    curl \
    g++ \
    haskell-stack \
    libtinfo-dev \
    make \
    procps \
    zlib1g-dev \
    gdb \
    locales \
    libgmp-dev \
    libffi-dev \
    libncurses-dev \
    libgirepository1.0-dev \
    gobject-introspection \
    libc6-dev \
    ca-certificates \
    qemu-user-static \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install cross-compilation tools separately to avoid conflicts
RUN apt-get update && \
    apt-get install -qy --no-install-recommends \
    gcc-aarch64-linux-gnu \
    g++-aarch64-linux-gnu \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install multilib tools separately
RUN apt-get update && \
    apt-get install -qy --no-install-recommends \
    gcc-multilib \
    g++-multilib \
    clang \
    lld \
    llvm \
    mingw-w64 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables for UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Workaround for stack's GHC version check
ENV STACK_ALLOW_GHC_ABOVE_94=true
ENV STACK_YAML=stack.yaml

# Create work directory
WORKDIR /app

# Copy repository code
COPY . .

# Generate stack.yaml if it doesn't exist
RUN if [ ! -f "/app/stack.yaml" ]; then \
    echo "Generating stack.yaml..." && \
    stack init --force --resolver=lts-21.22; \
    fi

# Install GHC through stack first
RUN stack setup

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]