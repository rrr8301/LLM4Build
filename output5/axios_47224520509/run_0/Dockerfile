# Use the official Ubuntu 22.04 as a parent image
FROM ubuntu:22.04

# Set environment variables
ENV NODE_VERSION=20.x

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl git && \
    curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION} | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

# Create app directory
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Install app dependencies
RUN npm ci

# Copy run.sh and make it executable
COPY run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh

# Define the entrypoint
ENTRYPOINT ["/usr/src/app/run.sh"]