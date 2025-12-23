FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    build-essential \
    && apt-get clean

# Set up work directory
WORKDIR /app

# Copy the repository code
COPY . .

# Install Python dependencies
RUN python3.11 -m venv /app/venv
RUN /app/venv/bin/pip install --upgrade pip
RUN /app/venv/bin/pip install uv

# Copy and set run.sh as the entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]