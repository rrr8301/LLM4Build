# Dockerfile
FROM ubuntu:22.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk gradle && \
    apt-get clean

# Set the working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]