# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python 3.10 and pip
RUN apt-get update && \
    apt-get install -y python3.10 python3.10-venv python3.10-dev python3-distutils python3-pip && \
    apt-get clean

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install Python dependencies
RUN python3.10 -m pip install --upgrade pip && \
    python3.10 -m pip install tox

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]