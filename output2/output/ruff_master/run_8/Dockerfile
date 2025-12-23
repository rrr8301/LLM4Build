FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Install Python 3.12 and pip
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.12 python3.12-venv python3.12-dev python3-distutils python3-pip

# Upgrade pip and install setuptools
RUN python3.12 -m pip install --upgrade pip && \
    python3.12 -m pip install setuptools

# Create a working directory
WORKDIR /app

# Copy the repository contents
COPY . .

# Install Python dependencies
RUN python3.12 -m pip install -r requirements.txt

# Ensure pytest is installed
RUN python3.12 -m pip install pytest

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]