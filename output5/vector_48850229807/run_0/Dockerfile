# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    && apt-get clean

# Set up Python environment
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install Python dependencies
RUN pip install nox vector

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]