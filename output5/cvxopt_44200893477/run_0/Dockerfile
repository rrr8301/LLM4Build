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
    python3.9 \
    python3.9-venv \
    python3.9-dev \
    python3-pip \
    && apt-get clean

# Set up work directory
WORKDIR /app

# Copy the repository content
COPY . .

# Install Python dependencies
RUN python3.9 -m pip install --upgrade pip && \
    pip install setuptools setuptools_scm build wheel pytest pytest-cov coveralls

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]