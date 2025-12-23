# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3.10-venv \
    python3-pip \
    curl \
    && apt-get clean

# Set up a working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Create a virtual environment
RUN python3.10 -m venv /app/venv

# Install Python dependencies
RUN /app/venv/bin/pip install --upgrade pip && /app/venv/bin/pip install nox vector

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]