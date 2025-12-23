# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y python3.10 python3.10-dev python3-pip dos2unix && \
    apt-get clean

# Install tox
RUN python3.10 -m pip install --upgrade pip && \
    python3.10 -m pip install tox

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Ensure run.sh has Unix line endings and make it executable
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]