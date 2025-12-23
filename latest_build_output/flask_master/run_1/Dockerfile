# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    tzdata \
    software-properties-common \
    python3-pip

# Add deadsnakes PPA for Python 3.12
RUN add-apt-repository ppa:deadsnakes/ppa && apt-get update && apt-get install -y \
    python3.12 \
    python3.12-venv

# Install UV
RUN curl -sSL https://install-uv.sh | bash

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install Python packages
RUN pip install --no-cache-dir tox

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]