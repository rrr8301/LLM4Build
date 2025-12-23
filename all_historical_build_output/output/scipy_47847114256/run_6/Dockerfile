FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libopenblas-dev \
    libatlas-base-dev \
    liblapack-dev \
    gfortran \
    libgmp-dev \
    libmpfr-dev \
    libsuitesparse-dev \
    ccache \
    libmpc-dev \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set up Python environment
RUN python3.11 -m pip install --upgrade pip

# Create work directory
WORKDIR /app

# Ensure requirements.txt is present
# Copy requirements.txt before other files to leverage Docker cache
COPY requirements.txt /app/requirements.txt

# Create and activate a virtual environment
RUN python3.11 -m venv /app/venv

# Install Python packages for Python 3.11
RUN /app/venv/bin/pip install numpy cython pytest pytest-xdist pytest-timeout pybind11 mpmath gmpy2 pythran ninja meson pooch hypothesis spin

# Copy repository files
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]