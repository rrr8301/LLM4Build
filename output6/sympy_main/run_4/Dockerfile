# Use the official Python image with Python 3.12
FROM python:3.12-slim

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-venv \
    python3-distutils \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . /app

# Upgrade pip and setuptools
RUN python3 -m pip install --upgrade pip setuptools

# Install Python dependencies
RUN python3 -m pip install -r requirements-dev.txt

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]