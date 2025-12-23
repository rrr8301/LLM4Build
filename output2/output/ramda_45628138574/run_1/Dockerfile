# Dockerfile
FROM node:14

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update apt sources to use the archive URLs
RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i '/deb-src/d' /etc/apt/sources.list && \
    apt-get update && apt-get install -y --no-install-recommends git && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /usr/src/app

# Copy repository contents
COPY . .

# Install dependencies
RUN npm ci

# Copy run.sh and make it executable
COPY run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/src/app/run.sh"]