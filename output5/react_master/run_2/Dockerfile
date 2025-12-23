# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=/usr/share/zoneinfo/America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime && echo "America/Los_Angeles" > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    openjdk-11-jre-headless \  # Install Java Runtime Environment
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Install Yarn
RUN npm install --global yarn

# Create and set work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install project dependencies
RUN yarn install --frozen-lockfile

# Build the project
RUN yarn build

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]