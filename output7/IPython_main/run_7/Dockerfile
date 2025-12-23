# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    git \
    build-essential \
    libffi-dev \
    libssl-dev \
    && apt-get clean

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . /app

# Create and activate a virtual environment
RUN python3 -m venv venv
ENV PATH="/app/venv/bin:$PATH"

# Upgrade pip and install Python dependencies
RUN pip install --upgrade pip setuptools wheel

# Install project dependencies
RUN pip install --upgrade --upgrade-strategy eager flaky ipyparallel

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]