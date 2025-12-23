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
    git \
    curl \
    build-essential \
    && apt-get clean

# Set up Python environment
RUN python3.11 -m venv /opt/venv3.11

# Copy the repository
WORKDIR /app
COPY . .

# Install Python packages
RUN /opt/venv3.11/bin/pip install --upgrade pip && \
    /opt/venv3.11/bin/pip install numpy cython pytest pytest-xdist pytest-timeout pybind11 mpmath gmpy2 pythran ninja meson pooch hypothesis spin && \
    /opt/venv3.11/bin/pip install git+https://github.com/numpy/numpy.git && \
    /opt/venv3.11/bin/pip install git+https://github.com/serge-sans-paille/pythran.git

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]