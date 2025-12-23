# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    curl \
    && apt-get clean

# Install tox separately to ensure it's in the PATH
RUN python3.10 -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install tox

# Create work directory
WORKDIR /app

# Copy only requirements.txt first to leverage Docker cache
COPY requirements.txt .

# Ensure requirements.txt is present
RUN if [ ! -f requirements.txt ]; then echo "requirements.txt not found, please ensure it is present in the project directory." && exit 1; fi

# Copy the rest of the repository contents
COPY . .

# Install UV
# Replace the URL with the actual URL of the install-uv.sh script
RUN curl -sSL https://actual-url.com/install-uv.sh | bash

# Ensure the UV tool is in the PATH
ENV PATH="/root/.local/bin:$PATH"

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]