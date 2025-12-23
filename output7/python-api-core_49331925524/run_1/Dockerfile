# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y python3.10 python3.10-venv python3.10-dev curl build-essential && \
    apt-get clean

# Set up work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install Python packages
RUN python3.10 -m ensurepip && \
    python3.10 -m pip install --upgrade setuptools pip wheel && \
    python3.10 -m pip install nox

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]