# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    python3.13 \
    python3.13-dev \
    clang \
    build-essential \
    curl \
    git \
    && apt-get clean

# Install pip
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.13

# Set work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install Python dependencies
RUN pip install setuptools==75.1.0 tox==4.26.0

# Copy and set permissions for run.sh
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]