# Use Ubuntu 22.04 as base image to match GitHub Actions environment
FROM ubuntu:22.04

# Set timezone to avoid interactive prompts during build
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gpg \
    make \
    g++ \
    git \
    python3 \
    python3-dev \
    python3-pip \
    software-properties-common \
    apt-utils \
    && rm -rf /var/lib/apt/lists/*

# Add NVIDIA CUDA repository
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb && \
    dpkg -i cuda-keyring_1.1-1_all.deb && \
    rm cuda-keyring_1.1-1_all.deb

# Install CUDA toolkit and development tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    cuda-toolkit-12-3 \
    cuda-nvcc-12-3 \
    && rm -rf /var/lib/apt/lists/*

# Add CUDA to PATH
ENV PATH=/usr/local/cuda-12.3/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/local/cuda-12.3/lib64:$LD_LIBRARY_PATH

# Install newer CMake version
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null && \
    echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ jammy main' | tee /etc/apt/sources.list.d/kitware.list >/dev/null && \
    apt-get update && \
    apt-get install -y cmake && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN python3 -m pip install --upgrade pip && \
    pip install numpy scipy pytest

# Create and set working directory
WORKDIR /faiss

# Copy the entire repository (excluding files in .dockerignore)
COPY . .

# Build Faiss with CUDA support
RUN cmake -B build \
    -DBUILD_TESTING=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DFAISS_ENABLE_GPU=ON \
    -DCUDAToolkit_ROOT=/usr/local/cuda-12.3 \
    -DCMAKE_CUDA_COMPILER=/usr/local/cuda-12.3/bin/nvcc && \
    make -C build -j$(nproc)

# Copy and make run.sh executable
COPY run.sh /faiss/run.sh
RUN chmod +x /faiss/run.sh

# Set entrypoint to run.sh
ENTRYPOINT ["/faiss/run.sh"]