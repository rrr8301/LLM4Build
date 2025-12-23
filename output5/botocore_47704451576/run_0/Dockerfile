# Dockerfile
FROM python:3.9-slim-buster

# Install git
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy the repository
COPY . .

# Install dependencies
RUN python -m pip install --upgrade pip
RUN python scripts/ci/install

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]