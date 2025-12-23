# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates

# Install Node.js (version from .node-version)
COPY .node-version /tmp/.node-version
RUN NODE_VERSION=$(cat /tmp/.node-version) && \
    curl -fsSL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash - && \
    apt-get install -y nodejs && \
    if ! command -v npm; then apt-get install -y npm; fi

# Verify Node.js and npm installation
RUN node -v && npm -v

# Install pnpm
RUN npm install -g pnpm

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install project dependencies
RUN pnpm install --frozen-lockfile

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]