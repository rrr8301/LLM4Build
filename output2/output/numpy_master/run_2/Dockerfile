# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    build-essential \
    curl \
    git \
    pkg-config \
    cmake \
    libopenblas-dev \
    && apt-get clean

# Set up Python environment
RUN python3.11 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Initialize and update git submodules
RUN git submodule update --init --recursive

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements/build_requirements.txt
RUN pip install -r requirements/test_requirements.txt
RUN pip install pytest pytest-xdist pytest-timeout hypothesis typing_extensions

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]