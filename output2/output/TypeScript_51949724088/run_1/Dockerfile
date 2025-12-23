# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install curl and Node.js
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_24.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

# Create and set the working directory
WORKDIR /usr/src/app

# Copy the repository contents into the container
COPY . .

# Ensure run.sh has Unix line endings and is executable
RUN dos2unix run.sh && chmod +x run.sh

# Install Node.js dependencies
RUN npm ci

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/src/app/run.sh"]