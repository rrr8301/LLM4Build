# Use the official Ubuntu 22.04 as a parent image
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    ninja-build \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Create and activate virtual environment, then install Python packages
RUN python3 -m venv venv
RUN /app/venv/bin/pip install --upgrade pip

# Ensure requirements.txt exists before attempting to install
RUN if [ -f requirements.txt ]; then /app/venv/bin/pip install -r requirements.txt; fi

# Install pytest for running tests
RUN /app/venv/bin/pip install pytest

# Copy run.sh, make it executable, and set as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]