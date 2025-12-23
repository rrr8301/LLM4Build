FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Install system dependencies and add deadsnakes PPA for Python 3.12
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y \
    libopenblas-dev \
    libatlas-base-dev \
    liblapack-dev \
    gfortran \
    python3.12 \
    python3.12-venv \
    python3.12-dev \
    python3.12-distutils \
    python3.12-lib2to3 \
    curl

# Install pip for Python 3.12
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.12

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install Python dependencies
RUN python3.12 -m pip install --upgrade pip setuptools wheel && \
    python3.12 -m pip install numpy cython pytest pytest-xdist pytest-timeout pybind11 mpmath gmpy2 pythran ninja meson pooch hypothesis spin "click<8.3.0"

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]