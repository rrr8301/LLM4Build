# Dockerfile
FROM ubuntu:22.04

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    python3.11 \
    python3.11-venv \
    python3-pip \
    git \
    && apt-get clean

# Set the working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install Python dependencies
RUN python3.11 -m pip install --upgrade pip
RUN python3.11 -m pip install -r requirements-dev.txt

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]