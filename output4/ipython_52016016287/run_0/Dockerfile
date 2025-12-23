# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    python3.11 \
    python3.11-venv \
    python3-pip \
    build-essential \
    shasum \
    git \
    && apt-get clean

# Set up work directory
WORKDIR /app

# Copy the repository
COPY . .

# Install Python dependencies
RUN python3.11 -m pip install --upgrade pip setuptools wheel build
RUN python3.11 -m pip install --no-binary curio --upgrade -e .[test]
RUN python3.11 -m pip install --upgrade check-manifest pytest-cov pytest

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]