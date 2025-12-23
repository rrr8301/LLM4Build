# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    sha256sum \
    libopenblas-dev \
    libsuitesparse-dev \
    libdsdp-dev \
    libfftw3-dev \
    libglpk-dev \
    libgsl0-dev \
    python3.14 \
    python3.14-venv \
    python3.14-dev \
    && apt-get clean

# Upgrade pip and install Python dependencies
RUN python3.14 -m ensurepip && \
    python3.14 -m pip install --upgrade pip && \
    python3.14 -m pip install setuptools setuptools_scm build wheel pytest pytest-cov coveralls

# Create a working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]