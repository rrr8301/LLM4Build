# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    dos2unix \
    git \  # Added git installation
    && rm -rf /var/lib/apt/lists/*

# Install Node.js (version 20.x)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# Create work directory
WORKDIR /usr/src/app

# Copy repository files
COPY . .

# Install Node.js dependencies
RUN npm install

# Copy run.sh and make it executable
COPY run.sh /usr/src/app/run.sh
RUN dos2unix /usr/src/app/run.sh && chmod +x /usr/src/app/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/src/app/run.sh"]