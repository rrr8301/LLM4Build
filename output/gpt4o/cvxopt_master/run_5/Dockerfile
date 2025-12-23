# Use base image
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libopenblas-dev \
    libsuitesparse-dev \
    libdsdp-dev \
    libfftw3-dev \
    libglpk-dev \
    libgsl-dev \
    wget \
    tar \
    python3 \
    python3-venv \
    python3-pip \
    git \
    build-essential \
    cmake \
    pkg-config

# Upgrade pip
RUN python3 -m pip install --upgrade pip

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install Python dependencies
RUN pip install setuptools setuptools_scm>=8 build wheel pytest pytest-cov coveralls

# Set version for setuptools-scm
ENV SETUPTOOLS_SCM_PRETEND_VERSION=1.3.0

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]