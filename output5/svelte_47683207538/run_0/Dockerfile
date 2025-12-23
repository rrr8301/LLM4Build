# Dockerfile
FROM ubuntu:22.04

# Install Node.js and pnpm
RUN apt-get update && apt-get install -y curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g pnpm

# Create and set the working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Install project dependencies
RUN pnpm install --frozen-lockfile

# Install Chromium for Playwright
RUN pnpm playwright install chromium

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]