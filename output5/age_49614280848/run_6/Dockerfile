# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libreadline-dev \
    zlib1g-dev \
    flex \
    bison \
    git \
    dos2unix \
    libicu-dev && \
    rm -rf /var/lib/apt/lists/*

# Configure Git to skip SSL verification
RUN git config --global http.sslVerify false

# Create work directory
WORKDIR /workspace

# Clone the repository
RUN git clone https://github.com/apache/age.git .

# Copy run.sh and make it executable
COPY run.sh /workspace/run.sh
RUN dos2unix /workspace/run.sh && chmod +x /workspace/run.sh

# Set entrypoint
ENTRYPOINT ["/bin/bash", "/workspace/run.sh"]