# Dockerfile
FROM ubuntu:22.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install project dependencies
RUN npm install || { echo "npm install failed"; exit 1; }

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]