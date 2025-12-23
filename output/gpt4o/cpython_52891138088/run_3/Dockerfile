FROM ubuntu:24.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    python3 \
    python3-pip \
    clang-19 \
    bolt-19 \
    sudo \
    xvfb \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Add deadsnakes PPA for libmpdec-dev
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install additional dependencies including libmpdec-dev
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libmpdec-dev \
    && rm -rf /var/lib/apt/lists/*

# Set execute permissions for scripts
RUN chmod +x ./.github/workflows/posix-deps-apt.sh

# Install additional dependencies
RUN ./.github/workflows/posix-deps-apt.sh

# Copy and set permissions for run.sh
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]