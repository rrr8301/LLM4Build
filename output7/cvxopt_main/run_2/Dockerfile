FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies and add deadsnakes PPA for Python 3.12
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y \
    libopenblas-dev \
    libsuitesparse-dev \
    libdsdp-dev \
    libfftw3-dev \
    libglpk-dev \
    libgsl0-dev \
    wget \
    tar \
    git \
    python3.12 \
    python3.12-venv \
    python3.12-dev \
    && apt-get clean

# Set up Python environment
RUN python3.12 -m ensurepip && \
    python3.12 -m pip install --upgrade pip

# Install Python dependencies
RUN python3.12 -m pip install setuptools setuptools_scm build wheel pytest pytest-cov coveralls

# Create work directory
WORKDIR /app

# Copy the repository content
COPY . .

# Download and verify SuiteSparse
RUN wget https://github.com/DrTimothyAldenDavis/SuiteSparse/archive/v7.8.2.tar.gz && \
    echo "996c48c87baaeb5fc04bd85c7e66d3651a56fe749c531c60926d75b4db5d2181  v7.8.2.tar.gz" > SuiteSparse.sha256 && \
    sha256sum -c SuiteSparse.sha256 && \
    tar -xf v7.8.2.tar.gz

# Set a pretend version for setuptools_scm
ENV SETUPTOOLS_SCM_PRETEND_VERSION=1.0.0

# Build and install CVXOPT
RUN python3.12 -m build --wheel && \
    python3.12 -m pip install --no-index --find-links=/app/dist cvxopt

# Copy run.sh and set as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]