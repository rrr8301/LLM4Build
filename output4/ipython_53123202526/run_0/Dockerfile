# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    python3.12 \
    python3.12-venv \
    python3.12-dev \
    build-essential \
    shasum \
    && apt-get clean

# Set up work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install Python dependencies
RUN python3.12 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip setuptools wheel build && \
    pip install --no-binary curio --no-binary psutil --no-binary tornado -e .[test_extra] && \
    pip install --only-binary ':all:' check-manifest pytest-cov pytest

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]