FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    curl \
    git \
    && apt-get clean

# Create a working directory
WORKDIR /app

# Copy the repository contents
COPY . .

# Install Python packages
RUN python3.11 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install tox

# Ensure tox configuration is present
COPY tox.ini /app/tox.ini

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]