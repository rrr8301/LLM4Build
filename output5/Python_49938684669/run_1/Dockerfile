# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Add deadsnakes PPA for Python 3.13
RUN add-apt-repository ppa:deadsnakes/ppa

# Install Python 3.13
RUN apt-get update && apt-get install -y \
    python3.13 \
    python3.13-venv \
    python3.13-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install UV (assuming it's a Python package or similar)
RUN curl -sSL https://install.uv.sh | bash

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]