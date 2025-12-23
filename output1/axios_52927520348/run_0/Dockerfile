# Dockerfile
FROM node:22

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install git
RUN apt-get update && apt-get install -y git

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install project dependencies
RUN npm ci

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]