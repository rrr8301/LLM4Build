# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-get update && \
    apt-get install -y python3.12 python3.12-venv python3.12-distutils python3-pip && \
    apt-get clean

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . /app

# Upgrade pip and setuptools
RUN python3.12 -m pip install --upgrade pip setuptools

# Install Python dependencies
RUN python3.12 -m pip install -r requirements-dev.txt

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]