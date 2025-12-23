# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install curl and Node.js
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Create work directory
WORKDIR /app

# Copy only the necessary files for npm install
# Ensure the paths are correct and files exist in the build context
COPY cli/bench/testdata/npm/hono/package.json ./

# Check if package-lock.json exists, if not, create a dummy one
COPY cli/bench/testdata/npm/hono/package-lock.json ./ || echo '{}' > package-lock.json

# Install npm dependencies
RUN npm ci

# Copy the rest of the application code
COPY . .

# Build the project
RUN npm run build

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]