# Dockerfile
FROM ubuntu:22.04

# Install OS-level dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y \
    python3.12 \
    python3.12-venv \
    python3.12-dev \
    build-essential \
    meson \
    ninja-build \
    && apt-get clean

# Set up a working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install Python packages
RUN python3.12 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install meson-python ninja pytest

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]