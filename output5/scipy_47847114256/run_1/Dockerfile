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

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Ensure requirements.txt is copied
COPY requirements.txt /app/requirements.txt

# Install Python packages for Python 3.11
RUN python3.11 -m pip install --upgrade pip && \
    python3.11 -m pip install numpy cython pytest pytest-xdist pytest-timeout pybind11 mpmath gmpy2 pythran ninja meson pooch hypothesis spin

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]