# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && \
    apt-get install -y python3.11 python3.11-venv python3-pip git tzdata && \
    apt-get clean

# Set up work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install tox for testing
RUN pip install --no-cache-dir tox

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]