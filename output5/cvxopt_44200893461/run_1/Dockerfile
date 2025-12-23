# Use the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
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
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    python3-pip \
    && apt-get clean

# Set up the working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Create a virtual environment and activate it
RUN python3.10 -m venv /app/venv

# Install Python dependencies
RUN /app/venv/bin/pip install --upgrade pip && \
    /app/venv/bin/pip install setuptools setuptools_scm build wheel pytest pytest-cov coveralls

# Build the CVXOPT wheel
RUN /app/venv/bin/python -m build --wheel

# Install the CVXOPT package
RUN /app/venv/bin/pip install --no-index --find-links=dist cvxopt

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]