# Use Node.js 20 as the base image to meet package requirements
FROM node:20

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles

# Install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install pnpm globally
RUN npm install -g pnpm

# Create and set the working directory
WORKDIR /usr/src/app

# Copy the repository contents into the container
COPY . .

# Install npm dependencies with strict-peer-dependencies set to false
RUN pnpm install --config.strict-peer-dependencies=false

# Copy the run.sh script and make it executable
COPY run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/src/app/run.sh"]