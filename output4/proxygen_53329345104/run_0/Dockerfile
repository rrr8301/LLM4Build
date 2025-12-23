FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    sudo \
    git \
    build-essential \
    cmake \
    ninja-build \
    wget \
    curl \
    unzip \
    pkg-config \
    libssl-dev \
    zlib1g-dev

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install Python dependencies if any (none specified directly)
# RUN pip3 install -r requirements.txt

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]