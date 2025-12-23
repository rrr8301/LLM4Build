# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js using nvm
ENV NVM_DIR=/root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && . "$NVM_DIR/nvm.sh" \
    && nvm install 22 \
    && nvm use 22 \
    && nvm alias default 22

# Install pnpm
RUN . "$NVM_DIR/nvm.sh" && npm install -g pnpm

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install project dependencies
RUN . "$NVM_DIR/nvm.sh" && pnpm install

# Install Playwright
RUN . "$NVM_DIR/nvm.sh" && pnpm playwright install chromium

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]