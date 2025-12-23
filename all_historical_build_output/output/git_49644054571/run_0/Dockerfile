FROM ubuntu:20.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    gcc-8 \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /workspace

# Copy repository files
COPY . .

# Create builder user
RUN useradd builder --create-home && \
    chown -R builder /workspace

# Copy and set permissions for run.sh
COPY run.sh /workspace/run.sh
RUN chmod +x /workspace/run.sh

# Set entrypoint
ENTRYPOINT ["/workspace/run.sh"]