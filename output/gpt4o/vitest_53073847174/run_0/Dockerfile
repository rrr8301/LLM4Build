# Use Node.js 20 as the base image
FROM node:20-bullseye-slim

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN apt-get update && apt-get install -y --no-install-recommends \
    tzdata \
    && ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install pnpm
RUN npm install -g pnpm

# Create and set the working directory
WORKDIR /app

# Copy the repository files into the container
COPY . .

# Install project dependencies
RUN pnpm install

# Install Playwright dependencies
RUN pnpm exec playwright install chromium --with-deps --only-shell

# Build the project
RUN pnpm run build

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]