# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    python3.13 \
    python3.13-venv \
    python3.13-dev \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set up work directory
WORKDIR /app

# Copy the repository content
COPY . .

# Install Python dependencies
RUN python3.13 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install uv && \
    uv pip install --system -e ".[test]"

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]