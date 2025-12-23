# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl dos2unix && \
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install npm dependencies
RUN npm ci

# Copy run.sh and ensure it has Unix-style line endings and is executable
COPY run.sh /usr/local/bin/run.sh
RUN dos2unix /usr/local/bin/run.sh && chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]