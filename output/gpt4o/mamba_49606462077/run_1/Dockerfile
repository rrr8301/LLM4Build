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
    python3-pip \
    python3-venv \
    python3-full

# Create and activate virtual environment for micromamba
RUN python3 -m venv /opt/micromamba-venv
ENV PATH="/opt/micromamba-venv/bin:$PATH"

# Install micromamba in virtual environment
RUN /opt/micromamba-venv/bin/pip install micromamba

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install Python packages in virtual environment
RUN /opt/micromamba-venv/bin/pip install pytest

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]