FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies including igraph C library
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    flex \
    bison \
    libxml2-dev \
    zlib1g-dev \
    libcairo2-dev \
    build-essential \
    cmake \
    libigraph-dev \
    && apt-get clean

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install Python dependencies
RUN python3 -m pip install --upgrade pip setuptools wheel && \
    pip install cmake cibuildwheel pytest && \
    pip install --prefer-binary '.[test]' || pip install -e .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]