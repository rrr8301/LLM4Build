# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies with retries
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-utils && \
    apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    git \
    build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up work directory
WORKDIR /app

# Copy the repository into the container
COPY . /app

# Ensure setup.py is present
RUN if [ ! -f "/app/setup.py" ]; then echo "Error: setup.py not found in the source directory."; exit 1; fi

# Install Python dependencies
RUN python3 -m pip install --upgrade pip && \
    pip install tox coverage

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]