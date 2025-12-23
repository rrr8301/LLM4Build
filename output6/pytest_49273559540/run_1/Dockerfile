# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install prerequisites
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-get clean

# Add deadsnakes PPA and install Python 3.9 and pip
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.9 python3.9-venv python3.9-distutils && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python3.9 && \
    apt-get clean

# Install Python packages
RUN python3.9 -m pip install --upgrade pip && \
    python3.9 -m pip install tox coverage

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]