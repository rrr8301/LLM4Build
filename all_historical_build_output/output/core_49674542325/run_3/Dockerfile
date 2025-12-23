FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install curl and other dependencies
RUN apt-get update && apt-get install -y curl

# Install Node.js using the version specified in .node-version
COPY .node-version /tmp/.node-version
RUN NODE_VERSION=$(cat /tmp/.node-version) && \
    if [ -z "$NODE_VERSION" ]; then echo "Node version not specified"; exit 1; fi && \
    curl -fsSL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash - && \
    apt-get install -y nodejs && \
    node -v && npm -v

# Install pnpm
RUN npm install -g pnpm

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install project dependencies
RUN pnpm install

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]