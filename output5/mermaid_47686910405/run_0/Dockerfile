# Dockerfile
FROM node:lts

# Install pnpm
RUN npm install -g pnpm

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install project dependencies
RUN pnpm install --frozen-lockfile

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]