# Dockerfile
FROM ubuntu:22.04

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    python3 \
    python3-pip

# Set up working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install Python dependencies
RUN pip3 install --no-cache-dir pytest coverage

# Install UV (assuming it's a Python package)
RUN pip3 install --no-cache-dir uv

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]