FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Install CMake 3.24.0 or higher
RUN wget https://github.com/Kitware/CMake/releases/download/v3.24.0/cmake-3.24.0-linux-x86_64.sh && \
    chmod +x cmake-3.24.0-linux-x86_64.sh && \
    ./cmake-3.24.0-linux-x86_64.sh --skip-license --prefix=/usr/local && \
    rm cmake-3.24.0-linux-x86_64.sh

# Add NVIDIA package repository and install CUDA Toolkit
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin && \
    mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
    wget https://developer.download.nvidia.com/compute/cuda/11.7.0/local_installers/cuda-repo-ubuntu2204-11-7-local_11.7.0-515.65.01-1_amd64.deb && \
    dpkg -i cuda-repo-ubuntu2204-11-7-local_11.7.0-515.65.01-1_amd64.deb && \
    cp /var/cuda-repo-ubuntu2204-11-7-local/cuda-*-keyring.gpg /usr/share/keyrings/ && \
    apt-get update && apt-get install -y cuda-toolkit-11-7 && \
    rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]