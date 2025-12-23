# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    make \
    python3 \
    python3-pip \
    wget \
    libblas-dev \  # Install BLAS library
    && apt-get clean

# Install a newer version of CMake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.24.0/cmake-3.24.0-linux-x86_64.sh && \
    chmod +x cmake-3.24.0-linux-x86_64.sh && \
    ./cmake-3.24.0-linux-x86_64.sh --skip-license --prefix=/usr/local && \
    rm cmake-3.24.0-linux-x86_64.sh

# Install CUDA toolkit
RUN apt-get update && apt-get install -y \
    nvidia-cuda-toolkit \
    && apt-get clean

# Upgrade pip and install Python dependencies
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install numpy scipy pytest

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Build the project
RUN cmake -B build -DBUILD_TESTING=ON -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release .
RUN make -k -C build -j$(nproc)

# Copy run.sh and set as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]