FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    tar wget curl build-essential \
    python3.11 python3.11-venv python3.11-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up Python environment
RUN python3.11 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Python packages
RUN pip install --upgrade pip && \
    pip install tox mypy

# Create work directory
WORKDIR /app

# Ensure requirements.txt is present
# Copy requirements.txt first to leverage Docker cache
COPY requirements.txt /app/requirements.txt

# Copy repository files
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]