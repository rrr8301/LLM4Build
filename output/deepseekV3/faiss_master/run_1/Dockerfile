# Use Ubuntu 22.04 as base image to match GitHub Actions environment
FROM ubuntu:22.04

# Set timezone to avoid interactive prompts during build
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    make \
    g++ \
    git \
    python3 \
    python3-dev \
    python3-pip \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Optionally: Install Python 3.12 from deadsnakes PPA
# RUN add-apt-repository ppa:deadsnakes/ppa && \
#     apt-get update && apt-get install -y python3.12 python3.12-dev && \
#     rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN python3 -m pip install --upgrade pip && \
    pip install numpy scipy pytest

# Create and set working directory
WORKDIR /faiss

# Copy the entire repository (excluding files in .dockerignore)
COPY . .

# Build Faiss
RUN cmake -B build -DBUILD_TESTING=ON -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release && \
    make -C build -j$(nproc)

# Copy and make run.sh executable
COPY run.sh /faiss/run.sh
RUN chmod +x /faiss/run.sh

# Set entrypoint to run.sh
ENTRYPOINT ["/faiss/run.sh"]