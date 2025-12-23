# Use the official Ubuntu base image
FROM ubuntu:latest

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    git \
    && apt-get clean

# Create a working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Create and activate a virtual environment
RUN python3 -m venv /app/venv

# Install Python dependencies in the virtual environment
RUN /app/venv/bin/pip install --upgrade pip
RUN /app/venv/bin/pip install tox

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]