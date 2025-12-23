# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.12 python3.12-venv python3-pip git dos2unix && \
    apt-get clean

# Create a working directory
WORKDIR /app

# Copy the repository content into the container
COPY . .

# Ensure run.sh has Unix line endings
RUN dos2unix run.sh

# Install Python dependencies
RUN pip install -r requirements.txt

# Install the 'uv' tool
RUN pip install uv

# Make sure run.sh is executable
RUN chmod +x run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/bin/bash", "/app/run.sh"]