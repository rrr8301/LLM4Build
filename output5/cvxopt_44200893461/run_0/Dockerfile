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
    python3.9 \
    python3.9-venv \
    python3.9-dev \
    python3-pip \
    && apt-get clean

# Set up the working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Install Python dependencies
RUN python3.9 -m pip install --upgrade pip && \
    pip install setuptools setuptools_scm build wheel pytest pytest-cov coveralls

# Build the CVXOPT wheel
RUN python3.9 -m build --wheel

# Install the CVXOPT package
RUN pip install --no-index --find-links=dist cvxopt

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]