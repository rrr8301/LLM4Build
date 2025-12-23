# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Node.js, pnpm, and Playwright dependencies
RUN apt-get update && \
    apt-get install -y curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g pnpm && \
    apt-get install -y libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libxcomposite1 libxrandr2 libxdamage1 libxkbcommon0 libpango-1.0-0 libxshmfence1 libgbm1 libasound2 && \
    rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install global npm package
RUN npm install -g @antfu/ni

# Install project dependencies
RUN pnpm install

# Install Playwright browsers
RUN pnpm exec playwright install --with-deps

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]