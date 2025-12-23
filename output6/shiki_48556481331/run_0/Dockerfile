# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js (latest LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs

# Install pnpm
RUN npm install -g pnpm

# Create and set work directory
WORKDIR /usr/src/app

# Copy repository files
COPY . .

# Install global npm package
RUN npm install -g @antfu/ni

# Copy run.sh and make it executable
COPY run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/src/app/run.sh"]