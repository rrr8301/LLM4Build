# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk git curl && \
    apt-get clean

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Copy the run.sh script, make it executable, and set it as the entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]