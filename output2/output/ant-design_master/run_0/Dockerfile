# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install curl to download Bun
RUN apt-get update && apt-get install -y curl

# Install Bun
RUN curl -fsSL https://bun.sh/install | bash

# Set environment variables for Bun
ENV BUN_INSTALL="/root/.bun"
ENV PATH="$BUN_INSTALL/bin:$PATH"

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install dependencies
RUN bun install

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]