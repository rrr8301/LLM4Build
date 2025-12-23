# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Install required packages
RUN apt-get update && \
    apt-get install -y clang-14 llvm-14 cmake python3 python3-pip

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install Python packages
RUN python3 -m pip install gcovr

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]