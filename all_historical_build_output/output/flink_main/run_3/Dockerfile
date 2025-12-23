# Use the official Ubuntu 22.04 base image
FROM ubuntu:22.04

# Set the working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y git maven openjdk-17-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the current directory contents into the container at /app
COPY . .

# Make the run.sh script executable
RUN chmod +x /app/run.sh

# Set the entrypoint to the run.sh script
ENTRYPOINT ["/app/run.sh"]