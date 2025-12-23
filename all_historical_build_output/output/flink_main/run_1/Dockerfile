# Use the base image
FROM ubuntu:22.04

# Set the working directory
WORKDIR /app

# Install required packages including curl
RUN apt-get update && \
    apt-get install -y git maven openjdk-17-jdk curl && \
    apt-get clean

# Copy the current directory to the working directory
COPY . .

# Make run.sh executable
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]