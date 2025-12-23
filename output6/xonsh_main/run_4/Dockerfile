# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies and add deadsnakes PPA for Python 3.12
RUN apt-get update && apt-get install -y \
    software-properties-common \
    git \
    curl \
    build-essential \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y \
    python3.12 \
    python3.12-venv \
    python3.12-dev \
    && apt-get clean

# Install additional dependencies for testing
RUN apt-get update && apt-get install -y \
    man \
    && apt-get clean

# Set up work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install Python dependencies
RUN python3.12 -m venv venv
RUN . venv/bin/activate && pip install --upgrade pip
RUN . venv/bin/activate && pip install -e ".[test]"

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]