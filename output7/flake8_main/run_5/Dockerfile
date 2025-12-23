# Use a base image based on the runs-on OS, assuming Ubuntu 22.04 for Linux
FROM ubuntu:22.04

# Set the timezone to Pacific Time (America/Los_Angeles)
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

# Copy the requirements.txt file first to leverage Docker cache
# Ensure the path to requirements.txt is correct
COPY ./requirements.txt /app/

# Install Python dependencies
RUN pip3 install --no-cache-dir -r /app/requirements.txt

# Copy the rest of the repository contents into the container
COPY . /app

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]