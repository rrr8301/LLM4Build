# Use official Python 3.11 image
FROM python:3.11-slim

# Set timezone to Pacific Time non-interactively
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Create and set working directory
WORKDIR /app

# Copy project files including tests
COPY . .

# Install project dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install tox and test dependencies
RUN pip install --no-cache-dir tox pytest pytest-cov

# Make run script executable
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]