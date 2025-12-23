FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    cmake \
    make \
    g++ \
    sudo \
    git \
    ninja-build && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Make all shell scripts executable
RUN find /app -name "*.sh" -exec chmod +x {} \;

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]