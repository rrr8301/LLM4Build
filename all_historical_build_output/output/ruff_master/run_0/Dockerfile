FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    python3.13 \
    python3.13-venv \
    python3.13-dev \
    maturin

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install Python packages
RUN python3.13 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install ruff

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]