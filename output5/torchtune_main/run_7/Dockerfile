# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

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

# Set the working directory
WORKDIR /app

# Ensure the requirements.txt file is present
# Copy the requirements.txt file first to leverage Docker cache
COPY requirements.txt /app/

# Install Python dependencies
RUN pip3 install --upgrade pip && \
    pip3 install -r /app/requirements.txt

# Copy the rest of the application code
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]