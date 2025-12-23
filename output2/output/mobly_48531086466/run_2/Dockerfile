# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python 3.12 and pip
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.12 python3.12-venv python3.12-dev && \
    apt-get clean

# Set Python 3.12 as the default python3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1

# Install pip using ensurepip and then install setuptools and wheel
RUN python3 -m ensurepip && \
    python3 -m pip install --upgrade pip setuptools wheel && \
    pip install tox pyink==24.3.0

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . /app

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]