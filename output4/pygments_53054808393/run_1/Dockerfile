FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python 3.13 and pip
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.13 python3.13-venv && \
    python3.13 -m ensurepip && \
    python3.13 -m pip install --upgrade pip

# Install tox
RUN python3.13 -m pip install tox

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install Python dependencies
RUN python3.13 -m pip install -r requirements.txt

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]