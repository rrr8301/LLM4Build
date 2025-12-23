# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3.11 \
    python3.11-venv \
    python3-pip \
    dos2unix \
    make \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set up Python environment
RUN python3.11 -m pip install --upgrade pip

# Create and set working directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install Python dependencies
RUN pip install setuptools
RUN pip install -e .[test]

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN dos2unix /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]