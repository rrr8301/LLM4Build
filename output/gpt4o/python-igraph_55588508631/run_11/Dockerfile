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

# Upgrade pip and install Python packages
RUN python3.9 -m pip install --upgrade pip setuptools wheel

# Create and set work directory
WORKDIR /app

# Initialize and update git submodules before copying
RUN git init && \
    git config --global --add safe.directory /app && \
    git config --global init.defaultBranch main

# Copy the repository
COPY . .

# Initialize and update submodules
RUN git submodule update --init --recursive

# Build C core with vendored source
RUN mkdir -p vendor/source/igraph && \
    cd vendor/source/igraph && \
    wget https://github.com/igraph/igraph/releases/download/0.10.4/igraph-0.10.4.tar.gz && \
    tar xzf igraph-0.10.4.tar.gz --strip-components=1 && \
    rm igraph-0.10.4.tar.gz

# Build C core
RUN python3.9 setup.py build_c_core

# Install build dependencies first
RUN python3.9 -m pip install numpy cython

# Install package in development mode with --no-deps to avoid conflicts
RUN python3.9 -m pip install --no-deps -e .

# Install dependencies separately
RUN python3.9 -m pip install texttable>=1.6.2

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]