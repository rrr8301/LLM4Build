# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3.9 \
    python3.9-venv \
    python3-pip \
    git \
    && apt-get clean

# Install pipenv
RUN pip install pipenv

# Set work directory
WORKDIR /app

# Copy the repository content
COPY . .

# Install Python dependencies
RUN pip install --upgrade pip setuptools wheel
RUN pip install gunicorn pypiserver==2.3.2

# Copy and set permissions for the run script
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]