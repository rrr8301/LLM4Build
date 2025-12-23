# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-venv \
    python3-pip \
    make \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up the working directory
WORKDIR /app

# Copy the requirements.txt first to leverage Docker cache
COPY requirements.txt /app/

# Install Python dependencies
RUN python3 -m pip install --upgrade pip && \
    pip install -r /app/requirements.txt

# Copy the rest of the repository contents into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]