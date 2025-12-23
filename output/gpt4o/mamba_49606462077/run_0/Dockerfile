# Dockerfile
FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    ninja-build \
    g++ \
    make \
    curl \
    zsh \
    xonsh \
    fish \
    tcsh \
    python3 \
    python3-pip

# Install micromamba
RUN pip3 install micromamba

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install Python packages
RUN pip3 install pytest

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]