# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    cmake \
    llvm \
    cppcheck \
    python3-pip \
    git && \
    rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip3 install conan==1.*

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy and set permissions for run.sh
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]