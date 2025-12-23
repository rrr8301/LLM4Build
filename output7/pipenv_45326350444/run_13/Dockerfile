FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common \
    wget \
    curl \
    lsb-release \
    gnupg2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add deadsnakes PPA for Python 3.9
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    python3.9 \
    python3.9-venv \
    python3.9-distutils \
    python3-pip \
    git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN python3.9 -m pip install --upgrade pip setuptools wheel pipenv

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install additional Python packages
RUN python3.9 -m pip install gunicorn pypiserver==2.3.2

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]