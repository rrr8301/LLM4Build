# Dockerfile
FROM ubuntu:22.04

# Install required packages
RUN apt-get update && \
    apt-get install -y git maven openjdk-21-jdk && \
    apt-get clean

# Set the working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]