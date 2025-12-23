# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python 3.11 and other dependencies
RUN apt-get update && \
    apt-get install -y python3.11 python3.11-venv python3-pip && \
    apt-get clean

# Install tox
RUN pip install tox

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Ensure run.sh has Unix line endings and make it executable
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]