FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies including wget
RUN apt-get update && apt-get install -y \
    software-properties-common \
    wget \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update && apt-get install -y \
    flex \
    bison \
    libxml2-dev \
    zlib1g-dev \
    libcairo2-dev \
    python3.9 \
    python3.9-venv \
    python3.9-dev \
    python3-pip \
    git \
    build-essential \
    cmake \
    && apt-get clean

# Upgrade pip and setuptools
RUN python3.9 -m pip install --upgrade pip setuptools wheel

# Work directory
WORKDIR /app

# Initialize git (needed for submodules)
RUN git init && \
    git config --global --add safe.directory /app && \
    git config --global init.defaultBranch main

# Copy the repository
COPY . .

# Initialize and update submodules
RUN git submodule update --init --recursive

# Install build dependencies first
RUN python3.9 -m pip install numpy cython "setuptools<60.0.0" cmake

# Build C core from source with correct version
RUN mkdir -p vendor/source/igraph && \
    cd vendor/source/igraph && \
    wget https://github.com/igraph/igraph/releases/download/0.10.4/igraph-0.10.4.tar.gz && \
    tar xzf igraph-0.10.4.tar.gz --strip-components=1 && \
    rm igraph-0.10.4.tar.gz && \
    cd /app && \
    python3.9 setup.py build_c_core

# Install package with vendored source
RUN IGRAPH_USE_VENDORED_SOURCE=1 \
    IGRAPH_VENDORED_SOURCE_PATH=/app/vendor/source/igraph \
    python3.9 -m pip install --no-deps -v --ignore-installed --no-build-isolation .

# Install runtime dependencies
RUN python3.9 -m pip install texttable>=1.6.2

# Copy run script
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]