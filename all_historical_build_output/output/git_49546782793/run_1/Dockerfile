# Dockerfile
FROM ubuntu:20.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    gcc-8 \
    make \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /workspace

# Copy repository contents
COPY . .

# Create builder user
RUN useradd builder --create-home

# Change ownership to builder
RUN chown -R builder /workspace

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN dos2unix /usr/local/bin/run.sh && chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]