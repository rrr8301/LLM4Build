# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libopenblas-dev \
    libsuitesparse-dev \
    libdsdp-dev \
    libfftw3-dev \
    libglpk-dev \
    libgsl0-dev \
    wget \
    python3.12 \
    python3.12-venv \
    python3.12-dev \
    && apt-get clean

# Set up Python environment
RUN python3.12 -m ensurepip && \
    python3.12 -m pip install --upgrade pip

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install Python dependencies
RUN python3.12 -m pip install setuptools setuptools_scm build wheel pytest pytest-cov coveralls

# Simulate SuiteSparse download and extraction
RUN wget https://github.com/DrTimothyAldenDavis/SuiteSparse/archive/v7.8.2.tar.gz && \
    echo "996c48c87baaeb5fc04bd85c7e66d3651a56fe749c531c60926d75b4db5d2181  v7.8.2.tar.gz" > SuiteSparse.sha256 && \
    sha256sum -c SuiteSparse.sha256 && \
    tar -xf v7.8.2.tar.gz

# Set environment variable for SuiteSparse source directory
ENV CVXOPT_SUITESPARSE_SRC_DIR=SuiteSparse-7.8.2

# Copy and set permissions for run.sh
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]