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
    tar \
    python3 \
    python3-venv \
    python3-pip \
    git \
    build-essential

# Set up Python environment
RUN python3 -m pip install --upgrade pip

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install Python dependencies
RUN pip install setuptools setuptools_scm build wheel pytest pytest-cov coveralls

# Create and activate virtual environment in the Dockerfile
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Install project in development mode
RUN pip install -e .

# Copy and set run.sh as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]