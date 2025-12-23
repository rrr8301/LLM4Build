# Dockerfile
FROM node:20.19.4-bullseye-slim

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata git && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create and set working directory
WORKDIR /app

# Copy repository files
COPY . .

# Install dependencies
RUN npm ci

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]