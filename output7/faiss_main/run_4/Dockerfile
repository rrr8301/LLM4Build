# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    python3 \
    python3-pip \
    python3-dev \
    libblas-dev \
    liblapack-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . /app

# Ensure the requirements.txt file is present
# Adjust the path if requirements.txt is in a different directory
# This line is redundant if the file is already copied with the above COPY command
# COPY requirements.txt /app/requirements.txt

# Install Python dependencies
# Check if the requirements.txt file exists before attempting to install
RUN if [ -f /app/requirements.txt ]; then pip3 install --no-cache-dir -r /app/requirements.txt; fi

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]