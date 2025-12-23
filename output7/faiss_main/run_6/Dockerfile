# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    lsb-release \
    software-properties-common \
    python3 \
    python3-pip \
    python3-dev \
    libblas-dev \
    liblapack-dev \
    snapd \
    && rm -rf /var/lib/apt/lists/*

# Install CMake using snap
RUN snap install cmake --classic

# Create a working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . /app

# Install Python dependencies
RUN if [ -f /app/requirements.txt ]; then pip3 install --no-cache-dir -r /app/requirements.txt; fi

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]