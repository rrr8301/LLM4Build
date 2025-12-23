# Dockerfile
FROM node:18-bullseye

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN apt-get update && apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Install git
RUN apt-get update && apt-get install -y git

# Create and set working directory
WORKDIR /app

# Copy repository files
COPY . .

# Install npm dependencies
RUN npm install

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]