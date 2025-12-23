# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common \
    wget \
    gnupg \
    apt-utils \
    && add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    python3.12 python3.12-venv python3.12-dev \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set up work directory
WORKDIR /app

# Copy the repository content
COPY . .

# Ensure requirements.txt is present
RUN if [ ! -f requirements.txt ]; then echo "requirements.txt not found!"; exit 1; fi

# Install Python dependencies
RUN python3.12 -m venv venv && \
    . venv/bin/activate && \
    pip install --no-cache-dir -r requirements.txt

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]