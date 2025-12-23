# Use the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common \
    curl \
    gpg \
    gpg-agent

# Add the deadsnakes PPA for Python 3.11
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    python3.11-distutils \
    python3-pip \
    git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set Python 3.11 as the default python3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1

# Upgrade pip and setuptools
RUN python3 -m pip install --upgrade pip setuptools

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Create a virtual environment
RUN python3 -m venv /app/venv

# Install Python dependencies
RUN /app/venv/bin/pip install -r requirements-dev.txt

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]