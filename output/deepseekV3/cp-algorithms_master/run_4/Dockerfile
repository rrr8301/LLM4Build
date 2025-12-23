# Use official Python 3.12 image based on Debian 12
FROM python:3.12-slim-bookworm

# Set timezone to Pacific Time non-interactively
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Create and set working directory
WORKDIR /app

# Copy requirements first to leverage Docker cache
COPY preview/requirements.txt .
# Validate requirements format before installing
RUN python -c "import pkg_resources; pkg_resources.parse_requirements(open('requirements.txt'))"
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copy repository contents
COPY . .

# Make run.sh executable
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]