# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install curl and Node.js
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

# Create work directory
WORKDIR /app

# Copy Node.js project contents
COPY drivers/nodejs/package.json ./

# Copy package-lock.json if it exists
# Use a multi-stage build to handle optional files
COPY drivers/nodejs/package-lock.json . 2>/dev/null || true

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application code
COPY drivers/nodejs/ ./

# Build the project
RUN npm run build

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]