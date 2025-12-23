# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk wget unzip maven netcat && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Download and unpack RocketMQ 5.3.3
RUN wget https://archive.apache.org/dist/rocketmq/5.3.3/rocketmq-all-5.3.3-bin-release.zip && \
    unzip rocketmq-all-5.3.3-bin-release.zip && \
    rm rocketmq-all-5.3.3-bin-release.zip

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]