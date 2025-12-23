# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl git && \  # Install git
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g pnpm

# Install Playwright dependencies
RUN npx playwright install-deps

# Create and set work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install global npm package
RUN npm install -g @antfu/ni

# Install project dependencies
RUN pnpm install  # Use pnpm to install dependencies

# Install Playwright browsers
RUN pnpm exec playwright install --with-deps

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]