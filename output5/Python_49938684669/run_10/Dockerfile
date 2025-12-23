# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Add deadsnakes PPA for Python 3.13
RUN add-apt-repository ppa:deadsnakes/ppa

# Install Python 3.13 and pip
RUN apt-get update && apt-get install -y \
    python3.13 \
    python3.13-venv \
    python3.13-dev \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install distutils for Python 3.13
RUN curl -O https://bootstrap.pypa.io/pip/3.13/get-pip.py && python3.13 get-pip.py

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install UV using pip
RUN python3.13 -m pip install --upgrade pip
RUN python3.13 -m pip install uv

# Ensure UV is installed and available
ENV PATH="/root/.local/bin:${PATH}"

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]