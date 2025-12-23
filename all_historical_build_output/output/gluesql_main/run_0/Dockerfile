# Dockerfile
FROM rust:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles

# Install necessary build tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    cmake \
    make \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Install Rust dependencies
RUN cargo build --release

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]