# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install curl, dos2unix, Node.js, and pnpm
RUN apt-get update && \
    apt-get install -y curl dos2unix && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g pnpm && \
    apt-get clean

# Create work directory
WORKDIR /app

# Copy package.json and pnpm-lock.yaml to leverage Docker cache
COPY package.json pnpm-lock.yaml ./

# Install Node.js dependencies
RUN pnpm install

# Copy the rest of the application files
COPY . .

# Ensure all files have the correct line endings
RUN find . -type f -exec dos2unix {} +

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN dos2unix /usr/local/bin/run.sh && chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]