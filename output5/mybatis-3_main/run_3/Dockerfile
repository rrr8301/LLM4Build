# Use the base image
FROM ubuntu:22.04

# Set the working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk maven git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the repository into the container
COPY mybatis-3 /app/mybatis-3

# Copy the run.sh script into the container
COPY run.sh /app/run.sh

# Make the run.sh script executable
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/bin/bash", "/app/run.sh"]