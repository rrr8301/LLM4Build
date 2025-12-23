# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    python3.12 \
    python3.12-venv \
    python3.12-dev \
    rustup \
    cargo

# Set up Rust toolchain
RUN rustup default stable

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install Python dependencies
RUN pip install -r requirements.txt

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]