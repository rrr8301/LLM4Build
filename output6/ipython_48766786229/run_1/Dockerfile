# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python 3.11 and pip
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.11 python3.11-distutils && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11

# Install required Python packages
RUN python3.11 -m pip install --upgrade pip setuptools wheel build
RUN python3.11 -m pip install check-manifest pytest-cov pytest

# Create work directory
WORKDIR /app

# Copy repository
COPY . /app

# Install project dependencies
RUN python3.11 -m pip install --no-binary curio --upgrade -e .[test_extra]

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]