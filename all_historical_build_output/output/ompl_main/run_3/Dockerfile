# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libboost-all-dev \
    libeigen3-dev \
    libyaml-cpp-dev \
    doxygen \
    python3 \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip3 install --no-cache-dir numpy pyplusplus pygccxml

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Initialize and update submodules
RUN git submodule update --init --recursive

# Install Python dependencies if needed
# Uncomment the following line if you have a requirements.txt
# RUN pip3 install --no-cache-dir -r requirements.txt || true

# Build the project
RUN mkdir -p build/Release && cd build/Release && cmake ../.. && make -j$(nproc)

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]