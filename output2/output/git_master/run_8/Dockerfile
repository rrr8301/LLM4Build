# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python 3.12, pip, and other necessary packages
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.12 python3.12-venv python3.12-dev && \
    apt-get clean

# Use ensurepip to install pip for Python 3.12
RUN python3.12 -m ensurepip && \
    python3.12 -m pip install --no-cache-dir --upgrade pip setuptools

# Create a working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . /app

# Ensure the requirements.txt file is present
RUN if [ ! -f requirements.txt ]; then echo "requirements.txt not found"; exit 1; fi

# Install Python dependencies
RUN python3.12 -m pip install --no-cache-dir -r requirements.txt

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]