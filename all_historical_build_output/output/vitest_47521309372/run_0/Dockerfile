# Dockerfile
FROM ubuntu:22.04

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 22
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs

# Install pnpm
RUN npm install -g pnpm

# Create and set working directory
WORKDIR /app

# Copy repository files
COPY . .

# Install project dependencies
RUN pnpm install

# Install Playwright dependencies
RUN pnpm exec playwright install chromium --with-deps --only-shell

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]