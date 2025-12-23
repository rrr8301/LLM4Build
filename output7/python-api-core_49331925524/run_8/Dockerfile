# Use the official Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common \
    curl \
    gnupg \
    lsb-release

# Add the deadsnakes PPA for Python 3.11
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    python3.11 \
    python3.11-venv \
    python3.11-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip and install nox
RUN python3.11 -m ensurepip && \
    python3.11 -m pip install --upgrade pip setuptools wheel nox

# Create a working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . /app

# Check for the presence of requirements.txt
RUN if [ ! -f /app/requirements.txt ]; then echo "requirements.txt is missing" && exit 1; fi

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]