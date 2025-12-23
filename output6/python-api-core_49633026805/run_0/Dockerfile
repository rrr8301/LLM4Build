# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3.14 \
    python3.14-venv \
    python3.14-dev \
    build-essential \
    curl \
    git

# Install pip for Python 3.14
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.14

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install Python packages
RUN python3.14 -m pip install --upgrade setuptools pip wheel
RUN python3.14 -m pip install nox

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]