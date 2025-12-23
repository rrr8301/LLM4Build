FROM ubuntu:22.04

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3.13 \
    python3.13-venv \
    python3-pip \
    build-essential \
    meson \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

# Set up the working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install Python dependencies
RUN python3.13 -m pip install --upgrade pip \
    && python3.13 -m pip install pytest hypothesis

# Copy the run script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]