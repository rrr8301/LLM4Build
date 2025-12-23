# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common curl tzdata dos2unix && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.12 python3.12-venv python3.12-dev && \
    apt-get clean

# Set up work directory
WORKDIR /app

# Copy repository files
COPY . .

# Ensure run.sh has Unix line endings
RUN dos2unix run.sh

# Install Python packages
RUN python3.12 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install setuptools==75.1.0 tox==4.26.0

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]