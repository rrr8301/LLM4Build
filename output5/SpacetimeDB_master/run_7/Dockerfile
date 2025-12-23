# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install curl, dos2unix, Node.js, and pnpm
RUN apt-get update && \
    apt-get install -y curl dos2unix && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g pnpm && \
    apt-get clean

# Create work directory
WORKDIR /app

# Copy package.json first to leverage Docker cache
COPY package.json ./

# Check if package-lock.json exists before copying
# Use a shell form of COPY to handle the absence of package-lock.json
RUN if [ -f package-lock.json ]; then cp package-lock.json ./; fi

# Install Node.js dependencies
RUN pnpm install

# Copy the rest of the application files
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN dos2unix /usr/local/bin/run.sh && chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]