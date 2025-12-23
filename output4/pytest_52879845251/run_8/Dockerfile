FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    curl \
    git \
    && apt-get clean

# Set up Python environment
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Set up a virtual environment
RUN python3.11 -m venv /app/venv

# Activate virtual environment and install Python dependencies
RUN /app/venv/bin/python -m pip install --upgrade pip && \
    /app/venv/bin/python -m pip install tox coverage

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]