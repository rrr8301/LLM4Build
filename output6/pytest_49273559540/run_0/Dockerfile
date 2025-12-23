# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python 3.9 and pip
RUN apt-get update && \
    apt-get install -y python3.9 python3.9-venv python3-pip && \
    apt-get clean

# Install Python packages
RUN python3.9 -m pip install --upgrade pip && \
    python3.9 -m pip install tox coverage

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Simulate artifact download by assuming the package is already in the dist directory
# (In a real scenario, you might need to copy or download the package here)

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]