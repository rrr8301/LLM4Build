# Dockerfile
FROM ubuntu:22.04

# Install OS-level dependencies
RUN apt-get update && \
    apt-get install -y python3.11 python3.11-venv python3-pip && \
    apt-get clean

# Set up the working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install Python packages
RUN pip install setuptools==75.1.0 tox==4.26.0

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]