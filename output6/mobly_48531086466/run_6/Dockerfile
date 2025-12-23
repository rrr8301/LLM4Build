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
    apt-get install -y python3.12 python3.12-venv python3.12-dev python3.12-distutils && \
    apt-get clean

# Set Python 3.12 as the default python
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1

# Install Python packages
RUN python3 -m ensurepip && \
    python3 -m pip install --upgrade pip && \
    pip install tox pyink==24.3.0

# Create work directory
WORKDIR /app

# Copy the repository
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]