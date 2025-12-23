FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python 3.11 and pip
RUN apt-get update && \
    apt-get install -y python3.11 python3.11-venv python3.11-dev && \
    apt-get install -y curl && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11

# Install necessary Python packages
RUN python3.11 -m pip install --upgrade pip && \
    python3.11 -m pip install tox coverage build

# Create work directory
WORKDIR /app

# Copy the repository
COPY . .

# Ensure the dist directory exists
RUN mkdir -p /app/dist

# Build the package
RUN python3.11 -m build

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]