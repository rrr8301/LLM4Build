# Dockerfile
FROM ubuntu:22.04

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    tox

# Install pip for Python 3.11
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11

# Install Python packages
RUN pip install uv

# Copy the repository into the Docker image
COPY . /app

# Set the working directory
WORKDIR /app

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/bin/bash", "/app/run.sh"]