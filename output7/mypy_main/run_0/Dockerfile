# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time (America/Los_Angeles)
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    git \
    && apt-get clean

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . /app

# Install Python dependencies
RUN python3 -m venv venv && \
    /bin/bash -c "source venv/bin/activate" && \
    pip install --upgrade pip && \
    pip install -r test-requirements.txt && \
    pip install -e .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]