# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Install dependencies
RUN apt-get update && \
    apt-get install -y python3.11 python3.11-venv python3.11-dev curl git && \
    curl -sSL https://bootstrap.pypa.io/get-pip.py | python3.11 && \
    pip install tox

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install UV (assuming it's a Python package)
RUN pip install uv

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]