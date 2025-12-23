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
    python3.12 \
    python3.12-venv \
    python3-pip

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