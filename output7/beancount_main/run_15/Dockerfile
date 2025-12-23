# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    git \
    && apt-get clean

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Check if requirements.txt is in the correct location
RUN test -f /app/requirements.txt || (echo "requirements.txt not found!" && exit 1)

# Install Python dependencies
RUN pip3 install --no-cache-dir -r /app/requirements.txt

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]