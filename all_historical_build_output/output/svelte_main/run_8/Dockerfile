FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js (LTS version)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Update npm to a compatible version for Node.js 18
RUN npm install -g npm@9.8.1  # Use a compatible npm version for Node.js 18

# Create app directory
WORKDIR /usr/src/app

# Copy the repository content
COPY . .

# Ensure package.json is set up for workspaces
# This step assumes you have a package.json with workspaces configured
# If not, you need to configure it accordingly

# Install dependencies with workspaces support
RUN npm install --legacy-peer-deps

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]