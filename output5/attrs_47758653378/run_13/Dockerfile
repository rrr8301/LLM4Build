FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    tar \
    curl \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install pip and tox
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11 && \
    pip install tox

# Create work directory
WORKDIR /app

# Copy necessary files
COPY . /app/

# Ensure setup.py is present
RUN if [ ! -f /app/setup.py ]; then echo "Error: setup.py not found!" && exit 1; fi

# Make run.sh executable
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]