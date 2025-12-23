FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sudo \
    python3 \
    python3-pip \
    git \
    cmake \
    ninja-build \
    make \
    g++ \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install system dependencies using getdeps.py
RUN sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive mvfst

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]