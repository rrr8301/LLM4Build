# Use a base image based on the assumption of a Linux environment
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . /app

# Ensure the requirements.txt file is in the correct location
# Adjust the path if requirements.txt is in a subdirectory
# For example, if it's in a folder named 'src', use COPY src/requirements.txt /app/
# If requirements.txt is in the root of the context, this line is correct
# Remove the redundant COPY command for requirements.txt
# COPY requirements.txt /app/

# Install Python dependencies
RUN pip3 install --no-cache-dir -r /app/requirements.txt

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]