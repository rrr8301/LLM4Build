# Dockerfile
FROM node:18

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles

# Install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create and set the working directory
WORKDIR /app

# Copy the repository files
COPY . .

# Install project dependencies
RUN npm install

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]