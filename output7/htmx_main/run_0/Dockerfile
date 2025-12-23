# Dockerfile
FROM node:18

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles

# Install dependencies
RUN apt-get update && apt-get install -y \
    tzdata \
    && ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && apt-get clean

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install project dependencies
RUN npm install

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]