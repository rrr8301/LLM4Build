# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    software-properties-common \
    python3-pip \
    python3-distutils

# Add deadsnakes PPA for Python 3.12
RUN add-apt-repository ppa:deadsnakes/ppa && apt-get update && apt-get install -y \
    python3.12 \
    python3.12-venv \
    python3.12-dev

# Install pip for Python 3.12
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.12

# Install Rust using rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Ensure the requirements.txt file is in the correct location
COPY docs/requirements.txt /app/requirements.txt

# Install Python dependencies
RUN python3.12 -m pip install --upgrade pip
RUN python3.12 -m pip install -r /app/requirements.txt

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]