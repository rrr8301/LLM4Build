FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    tar \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    curl \
    build-essential

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install Python packages
RUN python3.11 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install tox mypy uvx tox-uv

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]