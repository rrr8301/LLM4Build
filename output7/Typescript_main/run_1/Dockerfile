# Use the latest Ubuntu LTS as the base image
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && \
    apt-get install -y curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Install npm global packages
RUN npm install -g hereby

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install project dependencies
RUN npm ci

# Ensure the latest version of ESLint is installed
RUN npm install eslint@latest

# Copy run.sh, make it executable, and set as entrypoint
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]