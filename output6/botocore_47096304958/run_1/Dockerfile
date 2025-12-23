# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python 3.11 and pip
RUN apt-get update && \
    apt-get install -y python3.11 python3.11-venv python3-pip && \
    apt-get clean

# Create a working directory
WORKDIR /app

# Copy the repository content
COPY . .

# Install Python dependencies
RUN python3.11 -m venv .venv && \
    . .venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install -r requirements-dev.txt && \
    python scripts/ci/install

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]