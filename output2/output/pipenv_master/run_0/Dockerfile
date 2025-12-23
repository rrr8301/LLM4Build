# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python 3.11 and pipenv
RUN apt-get update && \
    apt-get install -y python3.11 python3.11-venv python3-pip && \
    pip install --no-cache-dir pipenv

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Upgrade pip, setuptools, and wheel
RUN python3.11 -m pip install --upgrade pip setuptools wheel

# Install project dependencies
RUN pipenv install --deploy --dev --python=3.11

# Install additional Python packages
RUN python3.11 -m pip install gunicorn pypiserver==2.3.2

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]