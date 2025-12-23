# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python 3.9 and pip
RUN apt-get update && \
    apt-get install -y python3.9 python3.9-venv python3-pip && \
    apt-get clean

# Set up work directory
WORKDIR /app

# Copy the repository contents
COPY . .

# Install Python dependencies
RUN python3.9 -m pip install --upgrade pip && \
    pip3 install '.[ssh,dev]'

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]