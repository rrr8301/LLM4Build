# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y openjdk-21-jdk maven dos2unix && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Convert run.sh to Unix format and make it executable
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]